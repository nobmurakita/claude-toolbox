# toolbox

Claude Code でローカル環境を汚さずにツールやスクリプトを実行するスキルです。

Python、PDF操作、画像変換、データ処理など、Docker コンテナで隔離して実行します。

## 前提条件

- Docker が使用できる環境（Docker Desktop, Rancher Desktop, OrbStack, Lima など）

## インストール

```bash
curl -fsSL https://raw.githubusercontent.com/nobmurakita/claude-toolbox/main/install.sh | bash
```

## 使い方

必要な場面で Claude Code が自動的にこのスキルを使用します。

スラッシュコマンドで明示的に呼び出すこともできます:

```
/toolbox CSVをExcelに変換して
/toolbox script.py input.csv output.xlsx
```

## プリインストール済みツール

- **Python 3**: pandas, numpy, scipy, matplotlib, seaborn, plotly, openpyxl, xlsxwriter, pillow, requests, beautifulsoup4, pdfplumber, python-pptx, lxml, jinja2, pyyaml, tabulate, chardet, kaleido
- **PDF**: poppler-utils (pdftotext, pdfimages, pdftoppm), ghostscript, qpdf
- **画像・動画**: ffmpeg, imagemagick
- **基本ツール**: curl, wget, jq, git, zip, unzip, file
- **フォント**: Noto Sans CJK

追加ツールは `--commit` オプションで永続的にインストールできます。

## 構成

```
claude-toolbox/
├── install.sh
├── skills/
│   └── toolbox/
│       ├── SKILL.md
│       └── scripts/
│           └── toolbox
└── docker/
    └── Dockerfile
```
