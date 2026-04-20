# C# 15 Union Types Complete Guide (Raw)

Source: https://qiita.com/hez2010/items/b656c867f9e5f57cc1cd
Fetched: 2026-04-20

## What Are Union Types?
Allow values to be constrained to one of several specified types. Enable compile-time exhaustiveness checking in switch expressions.

## Syntax
```csharp
public union Pet(Cat, Dog, Bird);
```
Single line declares a Union type holding any of the three types. Compiler generates struct with single `object?` Value property internally.

## Use Cases
**Type-safe result handling:**
```csharp
public union Result<T>(T, Exception);
```

## Key Features
- Compile-time safety: enforced by type system
- Exhaustiveness checking: switch expressions detect missing cases
- Implicit conversions: no wrapper syntax needed
- Pattern matching integration: compiler auto-unwraps union values
- Custom methods can be added to union declarations
- `[Union]` attributes for existing types
- Non-boxing access via `TryGetValue`
- `IUnionMembers` interface for factory creation

## Design Philosophy
Nominal wrapper types rather than type erasure, preserving safety with generics and enabling future language evolution.
