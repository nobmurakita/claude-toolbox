# python-sandbox

Claude Code で Python を使った一時的な分析作業を Docker コンテナで実行するスキルです。

システムの Python や仮想環境を汚さず、隔離された環境で分析作業を行います。

## インストール

```bash
curl -fsSL https://raw.githubusercontent.com/nobmurakita/claude-python-sandbox/main/install.sh | bash
```

## 含まれるライブラリ

- データ処理・計算
  - pandas, numpy, scipy
- スプレッドシート・ドキュメント
  - openpyxl, xlsxwriter, lxml, python-pptx, pdfplumber
- 画像・可視化
  - pillow, matplotlib, seaborn
- Web・スクレイピング
  - requests, beautifulsoup4
- テキスト・テンプレート
  - jinja2, pyyaml, tabulate, chardet

追加ライブラリは都度インストールでき、`claude-python-sandbox-packages` ボリュームに永続化されます。

## 構成

```
claude-python-sandbox/
├── install.sh
├── skills/
│   └── python-sandbox/
│       └── SKILL.md
└── docker/
    └── Dockerfile
```
