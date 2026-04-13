#!/usr/bin/env -S uv run --quiet
# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "pyyaml>=6.0",
#   "click>=8.1",
#   "rich>=13.7",
# ]
# ///
"""Knowledge Vault CLI.

Subcommands:
  list   Filter wiki pages by type, tag, status
  tags   Show the tag library
  lint   Health-check the vault
  show   Show a specific wiki page

Filter syntax (for `list`):
  type:concept            # single value
  tag:ai/llm,ai/agent     # OR within field (comma)
  -tag:project/aaip       # exclude
  type:concept tag:ai/llm status:verified  # AND across fields

Example:
  vault-cli.py list type:how-to tag:infra/gcp status:verified
  vault-cli.py list tag:ai/llm,ai/agent -tag:archived
"""
from __future__ import annotations

import re
import sys
from dataclasses import dataclass, field
from pathlib import Path
from typing import Iterable

import click
import yaml
from rich.console import Console
from rich.table import Table

# ---------- Paths ----------

SCRIPT_DIR = Path(__file__).resolve().parent
REPO_ROOT = SCRIPT_DIR.parent.parent.parent  # plugins/vault/scripts -> repo root
VAULT_DIR = REPO_ROOT / "vault"
WIKI_DIR = VAULT_DIR / "wiki"
INDEX_FILE = VAULT_DIR / "index.md"
TAGS_FILE = VAULT_DIR / "tags.md"
NEWSLETTERS_DIR = VAULT_DIR / "newsletters"

console = Console()
err_console = Console(stderr=True)

# ---------- Data model ----------


@dataclass
class Page:
    path: Path
    type: str = ""
    status: list[str] = field(default_factory=list)
    tags: list[str] = field(default_factory=list)
    sources: list[str] = field(default_factory=list)
    created: str = ""
    updated: str = ""
    title: str = ""
    summary: str = ""
    raw_frontmatter: dict = field(default_factory=dict)

    @property
    def filename(self) -> str:
        return self.path.stem


def parse_frontmatter(text: str) -> tuple[dict, str]:
    """Extract YAML frontmatter from markdown. Returns (frontmatter_dict, body)."""
    if not text.startswith("---\n"):
        return {}, text
    end = text.find("\n---\n", 4)
    if end == -1:
        return {}, text
    fm_text = text[4:end]
    body = text[end + 5 :]
    try:
        fm = yaml.safe_load(fm_text) or {}
    except yaml.YAMLError:
        return {}, text
    return fm, body


def load_page(path: Path) -> Page | None:
    try:
        text = path.read_text(encoding="utf-8")
    except (OSError, UnicodeDecodeError):
        return None
    fm, body = parse_frontmatter(text)
    if not isinstance(fm, dict):
        fm = {}

    def as_list(v) -> list[str]:
        if v is None:
            return []
        if isinstance(v, list):
            return [str(x) for x in v]
        return [str(v)]

    title = ""
    summary = ""
    for line in body.splitlines():
        line = line.strip()
        if not title and line.startswith("# "):
            title = line[2:].strip()
            continue
        if title and line and not line.startswith("#"):
            summary = line[:120]
            break

    return Page(
        path=path,
        type=str(fm.get("type", "")),
        status=as_list(fm.get("status")),
        tags=as_list(fm.get("tags")),
        sources=as_list(fm.get("sources")),
        created=str(fm.get("created", "")),
        updated=str(fm.get("updated", "")),
        title=title or path.stem,
        summary=summary,
        raw_frontmatter=fm,
    )


def load_all_pages() -> list[Page]:
    if not WIKI_DIR.exists():
        return []
    pages: list[Page] = []
    for p in sorted(WIKI_DIR.rglob("*.md")):
        page = load_page(p)
        if page:
            pages.append(page)
    return pages


# ---------- Filter language ----------


@dataclass
class Clause:
    field_name: str
    values: list[str]
    exclude: bool


def parse_clauses(args: Iterable[str]) -> list[Clause]:
    """Parse CLI filter tokens into Clause objects.

    Accepts tokens like:
      type:concept
      tag:ai/llm,ai/agent
      -tag:project/aaip
      status:verified
    """
    clauses: list[Clause] = []
    for raw in args:
        token = raw.strip()
        if not token:
            continue
        exclude = False
        if token.startswith("-"):
            exclude = True
            token = token[1:]
        if ":" not in token:
            raise click.BadParameter(f"invalid filter token: {raw}")
        field_name, values_str = token.split(":", 1)
        field_name = field_name.strip()
        if field_name not in {"type", "tag", "status"}:
            raise click.BadParameter(
                f"unknown field '{field_name}'. allowed: type, tag, status"
            )
        values = [v.strip() for v in values_str.split(",") if v.strip()]
        if not values:
            raise click.BadParameter(f"no values for {field_name}")
        clauses.append(Clause(field_name, values, exclude))
    return clauses


def page_field_values(page: Page, field_name: str) -> list[str]:
    if field_name == "type":
        return [page.type] if page.type else []
    if field_name == "tag":
        return page.tags
    if field_name == "status":
        return page.status
    return []


def clause_matches(page: Page, clause: Clause) -> bool:
    values = page_field_values(page, clause.field_name)
    # OR semantics within a clause: page matches if any value overlaps.
    has_overlap = any(v in values for v in clause.values)
    if clause.exclude:
        return not has_overlap
    return has_overlap


def filter_pages(pages: list[Page], clauses: list[Clause], include_archived: bool) -> list[Page]:
    result = []
    for page in pages:
        if not include_archived and "archived" in page.status:
            # Explicit request (status:archived or -status:...) overrides hidden by default.
            wants_archived = any(
                c.field_name == "status" and "archived" in c.values and not c.exclude
                for c in clauses
            )
            if not wants_archived:
                continue
        if all(clause_matches(page, c) for c in clauses):
            result.append(page)
    return result


# ---------- Commands ----------


@click.group(context_settings={"help_option_names": ["-h", "--help"]})
def cli() -> None:
    """Knowledge Vault CLI."""


@cli.command(
    "list",
    context_settings={"ignore_unknown_options": True, "allow_interspersed_args": True},
)
@click.argument("filters", nargs=-1, type=click.UNPROCESSED)
@click.option("--all", "include_all", is_flag=True, help="Include archived pages")
@click.option("--json", "as_json", is_flag=True, help="Output as JSON")
def cmd_list(filters: tuple[str, ...], include_all: bool, as_json: bool) -> None:
    """List wiki pages filtered by type, tag, status.

    Examples:
      list                              # all pages (except archived)
      list type:concept
      list tag:ai/llm
      list type:concept tag:ai/llm status:verified
      list tag:ai/llm,ai/agent          # OR within a field
      list tag:ai/llm -tag:project/aaip # exclude
    """
    try:
        clauses = parse_clauses(filters)
    except click.BadParameter as e:
        err_console.print(f"[red]Error:[/red] {e.message}")
        sys.exit(2)

    pages = load_all_pages()
    matched = filter_pages(pages, clauses, include_archived=include_all)

    if as_json:
        import json

        data = [
            {
                "filename": p.filename,
                "type": p.type,
                "status": p.status,
                "tags": p.tags,
                "title": p.title,
                "summary": p.summary,
                "path": str(p.path.relative_to(REPO_ROOT)),
            }
            for p in matched
        ]
        click.echo(json.dumps(data, ensure_ascii=False, indent=2))
        return

    if not matched:
        console.print("[yellow]No pages matched.[/yellow]")
        return

    table = Table(title=f"Vault List ({len(matched)} pages)", show_lines=False)
    table.add_column("Page", style="cyan", no_wrap=True)
    table.add_column("Type", style="green")
    table.add_column("Status", style="magenta")
    table.add_column("Tags", style="blue", overflow="fold")
    table.add_column("Summary", overflow="fold")

    for p in matched:
        table.add_row(
            f"\\[\\[wiki/{p.filename}]]",
            p.type,
            ", ".join(p.status) if p.status else "—",
            ", ".join(p.tags) if p.tags else "—",
            p.summary or "—",
        )
    console.print(table)


@cli.command("tags")
def cmd_tags() -> None:
    """Show the tag library (vault/tags.md)."""
    if not TAGS_FILE.exists():
        err_console.print(f"[red]tags.md not found: {TAGS_FILE}[/red]")
        sys.exit(1)
    click.echo(TAGS_FILE.read_text(encoding="utf-8"))


@cli.command("show")
@click.argument("name")
def cmd_show(name: str) -> None:
    """Show a specific wiki page."""
    name = name.removesuffix(".md")
    path = WIKI_DIR / f"{name}.md"
    if not path.exists():
        err_console.print(f"[red]Page not found: {name}[/red]")
        sys.exit(1)
    click.echo(path.read_text(encoding="utf-8"))


# ---------- Lint ----------


@cli.command("lint")
def cmd_lint() -> None:
    """Health-check the vault.

    Checks:
      - broken [[wiki/...]] links
      - orphan pages (no incoming links)
      - pages missing from index.md
      - frontmatter schema (type required, status as list, tags as list)
      - unknown domain tags (tags with '/') not in tags.md
    """
    pages = load_all_pages()
    if not pages:
        console.print("[yellow]No pages in vault/wiki/.[/yellow]")
        return

    valid_types = extract_valid_types()
    valid_tags = extract_valid_tags()

    console.rule("[bold]Vault Lint Report[/bold]")
    console.print(f"wiki pages: {len(pages)}")

    # 1. broken links
    broken = find_broken_links(pages)
    section("Broken links", broken)

    # 2. orphan pages
    orphans = find_orphans(pages)
    section("Orphan pages (no incoming links)", orphans)

    # 3. missing from index
    missing_idx = find_unindexed(pages)
    section("Pages not in index.md", missing_idx)

    # 4. schema violations
    schema_errors = check_schema(pages, valid_types)
    section("Frontmatter schema violations", schema_errors)

    # 5. unknown domain tags
    unknown_tags = find_unknown_tags(pages, valid_tags)
    section("Unknown domain tags", unknown_tags)

    console.rule("[bold]Summary[/bold]")
    console.print(f"pages: {len(pages)}")
    console.print(f"broken links: {len(broken)}")
    console.print(f"orphans: {len(orphans)}")
    console.print(f"unindexed: {len(missing_idx)}")
    console.print(f"schema errors: {len(schema_errors)}")
    console.print(f"unknown tags: {len(unknown_tags)}")


def section(title: str, items: list[str]) -> None:
    console.print(f"\n[bold cyan]{title}[/bold cyan]")
    if items:
        for it in items:
            # Escape brackets so Rich does not interpret them as markup tags
            safe = it.replace("[", "\\[")
            console.print(f"  {safe}")
    else:
        console.print("  [green]OK[/green]")


def extract_valid_types() -> set[str]:
    """Parse tags.md for type names."""
    if not TAGS_FILE.exists():
        return set()
    text = TAGS_FILE.read_text(encoding="utf-8")
    types = set()
    # Look for `word` under "## Type 一覧" section until next "## "
    in_section = False
    for line in text.splitlines():
        if line.strip().startswith("## Type 一覧"):
            in_section = True
            continue
        if in_section and line.strip().startswith("## "):
            break
        if in_section:
            m = re.findall(r"`([a-z-]+)`", line)
            for name in m:
                if "/" not in name:
                    types.add(name)
    return types


def extract_valid_tags() -> set[str]:
    """Parse tags.md for domain tags (those containing '/')."""
    if not TAGS_FILE.exists():
        return set()
    text = TAGS_FILE.read_text(encoding="utf-8")
    tags = set()
    for m in re.finditer(r"`([a-z0-9][a-z0-9/_-]*)`", text):
        name = m.group(1)
        if "/" in name:
            tags.add(name)
    return tags


def find_broken_links(pages: list[Page]) -> list[str]:
    existing = {p.filename for p in pages}
    errors = []
    link_re = re.compile(r"\[\[wiki/([^\]]+)\]\]")
    for p in pages:
        try:
            text = p.path.read_text(encoding="utf-8")
        except OSError:
            continue
        for m in link_re.finditer(text):
            raw_target = m.group(1)
            # Obsidian alias syntax: [[wiki/foo|alias]] -> strip alias
            target = raw_target.split("|", 1)[0].strip()
            target = target.removesuffix(".md")
            if target not in existing:
                errors.append(f"{p.filename}.md -> [[wiki/{raw_target}]]")
    return errors


def find_orphans(pages: list[Page]) -> list[str]:
    """Pages with no incoming [[wiki/X]] links from wiki, newsletters, or index."""
    incoming: dict[str, int] = {p.filename: 0 for p in pages}
    link_re = re.compile(r"\[\[wiki/([^\]]+)\]\]")

    search_files: list[Path] = []
    search_files.extend(WIKI_DIR.rglob("*.md"))
    if NEWSLETTERS_DIR.exists():
        search_files.extend(NEWSLETTERS_DIR.rglob("*.md"))
    if INDEX_FILE.exists():
        search_files.append(INDEX_FILE)

    for f in search_files:
        try:
            text = f.read_text(encoding="utf-8")
        except OSError:
            continue
        for m in link_re.finditer(text):
            target = m.group(1).split("|", 1)[0].strip().removesuffix(".md")
            if target in incoming and f.stem != target:
                incoming[target] += 1

    return [f"{name}.md" for name, count in incoming.items() if count == 0]


def find_unindexed(pages: list[Page]) -> list[str]:
    if not INDEX_FILE.exists():
        return []
    text = INDEX_FILE.read_text(encoding="utf-8")
    missing = []
    for p in pages:
        if f"[[wiki/{p.filename}]]" not in text:
            missing.append(f"{p.filename}.md")
    return missing


def check_schema(pages: list[Page], valid_types: set[str]) -> list[str]:
    errors = []
    for p in pages:
        fm = p.raw_frontmatter
        if not fm:
            errors.append(f"{p.filename}.md: no frontmatter")
            continue
        if "type" not in fm:
            errors.append(f"{p.filename}.md: missing 'type' field")
        elif valid_types and fm.get("type") not in valid_types:
            errors.append(f"{p.filename}.md: unknown type '{fm.get('type')}'")
        if "status" not in fm:
            errors.append(f"{p.filename}.md: missing 'status' field")
        elif not isinstance(fm.get("status"), list):
            errors.append(f"{p.filename}.md: 'status' must be a list")
        if "tags" not in fm:
            errors.append(f"{p.filename}.md: missing 'tags' field")
        elif not isinstance(fm.get("tags"), list):
            errors.append(f"{p.filename}.md: 'tags' must be a list")
    return errors


def find_unknown_tags(pages: list[Page], valid_tags: set[str]) -> list[str]:
    if not valid_tags:
        return []
    errors = []
    for p in pages:
        for tag in p.tags:
            if "/" in tag and tag not in valid_tags:
                errors.append(f"{p.filename}.md: '{tag}'")
    return errors


if __name__ == "__main__":
    cli()
