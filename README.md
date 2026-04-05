# Claude Toolbox

Claude Code でローカル環境を汚さずにツールやスクリプトを実行するスキルです。

Python、PDF操作、画像変換、データ処理など、Docker コンテナで隔離して実行します。

## 前提条件

- Docker が使用できる環境（Docker Desktop, Rancher Desktop, OrbStack, Lima など）

## インストール

```bash
curl -fsSL https://raw.githubusercontent.com/nobmurakita/claude-toolbox/main/install.sh | bash
```

インストール時に Docker イメージ `claude-toolbox` がビルドされます。コマンドはこのイメージから起動されるコンテナ内で実行されます。

## 使い方

必要な場面で Claude Code が自動的にこのスキルを使用します。

スラッシュコマンドで明示的に呼び出すこともできます:

```
/toolbox CSVをExcelに変換して
/toolbox script.py input.csv output.xlsx
```

## プリインストール済みツール

- **基本ツール**: curl, wget, jq, git, zip, unzip, file, tree
- **PDF**: poppler-utils (pdftotext, pdfimages, pdftoppm), ghostscript, qpdf
- **画像・動画**: ffmpeg, imagemagick, rsvg-convert (librsvg)
- **ドキュメント変換**: pandoc
- **グラフ描画**: graphviz (dot, neato, etc.)
- **データベース**: sqlite3
- **フォント**: Noto Sans CJK
- **Python 3**: pandas, numpy, scipy, scikit-learn, networkx, matplotlib, seaborn, plotly, kaleido, openpyxl, xlsxwriter, pillow, requests, beautifulsoup4, pdfplumber, python-pptx, lxml, jinja2, pyyaml, tabulate, chardet, markdown, rich
- **Node.js 24**: nodejs, npm

追加ツールは `--commit` オプションで永続的にインストールできます。

## イメージの再構築

Docker イメージを初期状態に戻します。

Claude Code に依頼するか、手動で実行できます:

```
/toolbox イメージを再構築して
```

```bash
~/.claude/skills/toolbox/scripts/rebuild
```

## アンインストール

```bash
rm -rf ~/.claude/skills/toolbox
docker rmi claude-toolbox
```

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

## ライセンス

[MIT License](LICENSE)
