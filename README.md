# python-sandbox

Claude Code で Python を使った一時的な作業を Docker コンテナで実行するスキルです。

システムの Python やプロジェクトの仮想環境を汚さず、隔離された環境で実行します。

## インストール

```bash
curl -fsSL https://raw.githubusercontent.com/nobmurakita/claude-python-sandbox/main/install.sh | bash
```

## 使い方

Claude Code から `/python-sandbox` で呼び出せます。

```
/python-sandbox CSVをExcelに変換して
/python-sandbox script.py input.csv output.xlsx
```

## 含まれるライブラリ

- データ処理・計算
  - pandas, numpy, scipy
- スプレッドシート・ドキュメント
  - openpyxl, xlsxwriter, lxml, python-pptx, pdfplumber
- 画像・可視化
  - pillow, matplotlib, seaborn
- 日本語フォント
  - Noto Sans CJK
- Web・スクレイピング
  - requests, beautifulsoup4
- テキスト・テンプレート
  - jinja2, pyyaml, tabulate, chardet

追加ライブラリは都度インストールでき、`python-sandbox-packages` ボリュームに永続化されます。

## 構成

```
claude-python-sandbox/
├── install.sh
├── skills/
│   └── python-sandbox/
│       ├── SKILL.md
│       └── scripts/
│           └── python-sandbox
└── docker/
    └── Dockerfile
```
