---
type: insight
status: []
tags:
  - security/privacy
sources:
  - "https://www.eff.org/deeplinks/2026/04/google-broke-its-promise-me-now-ice-has-my-data"
created: 2026-04-16
updated: 2026-04-16
---

# Google・ICE データ提供事件：プラットフォームのプライバシー承諾破りの教訓

![Google Privacy](https://www.eff.org/files/banner_library/google-spy-eye.png)

Google が ICE（移民税関執行局）への行政召喚状に対し、事前通知なしにユーザーデータを提供した事件。EFF が告発し、プラットフォームの「通知ポリシー」の脆弱性を浮き彫りにした。

## 事件の経緯

1. 2024年9月: コーネル大学 PhD 候補の Amandla Thomas-Johnson がパレスチナ支持デモに参加
2. その後: ICE が行政召喚状を Google に送付
3. 2025年5月: Google が**事前通知なし**でデータ提供（従来の通知ポリシー違反）
4. Thomas-Johnson は最終通知を受け取ったが、データ提供後の事後通知のみ

## 取得されたデータ

- IP アドレス
- 物理アドレス
- セッション時間・期間

個別には無害に見えるデータだが、組み合わせると詳細な監視プロファイルを構成する。

## Google 通知ポリシーの変容

Google は約10年間、法執行機関からのデータ要求に対してユーザーに事前通知するポリシーを維持していた。しかし今回は通知なしで提供。EFF はこの変更を「約束の破棄」と批判。

## 重要な示唆

### 技術者への教訓
1. **プラットフォームのポリシーは変わる:** ユーザーデータの保護は企業の善意に依存してはならない
2. **行政召喚状の危険性:** 裁判所命令不要で発行可能、ユーザーが事前に抵抗する機会がない
3. **データ最小化の重要性:** 収集・保存するデータを最小化することでリスクを低減
4. **メタデータの脆弱性:** 個別データでなくメタデータの組み合わせが詳細プロファイルになる

### 影響を受けやすい人物
- 留学生・ビザ保有者
- 政治活動家
- ジャーナリスト

## EFF の対応

カリフォルニア州・ニューヨーク州の司法長官に不正競争行為（Deceptive Trade Practices）として申し立て。

## 関連ページ

- [[wiki/flock-lpr-privacy]] — Flock LPR の CCPA 削除要求拒否：監視インフラとプライバシー法
- [[wiki/wordpress-plugin-supply-chain-attack]] — サプライチェーンリスク：プラットフォーム依存の危険性
