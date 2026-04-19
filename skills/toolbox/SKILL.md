---
name: toolbox
description: |-
  一時的な作業にローカル環境にないツールやライブラリが必要な場合に使用する。
  ローカル環境を汚さないためにDockerコンテナ内のツールを使用して作業を行う。
  Python、Node.js の書き捨てのスクリプト実行、PDF操作、画像変換、データ処理など用途を問わない。
allowed-tools:
  - Bash(*/.claude/skills/toolbox/scripts/*)
---

# Toolbox

ローカル環境にないツールやコマンドを使いたい場合、必ずDockerコンテナ（toolbox）で実行すること。
ローカルへのインストール（brew, apt, pip 等）は行わず、このスキルを使うこと。

プロジェクト自体のコード（テスト、lint、アプリ起動など）はプロジェクトの環境で実行する。

## プリインストール済みツール

ベースイメージ: Ubuntu 24.04

- **基本ツール**: curl, wget, jq, git, zip, unzip, file, tree
- **PDF**: poppler-utils (pdftotext, pdfimages, pdftoppm), ghostscript, qpdf
- **画像・動画**: ffmpeg, imagemagick, rsvg-convert (librsvg)
- **ドキュメント変換**: pandoc
- **グラフ描画**: graphviz (dot, neato, etc.)
- **データベース**: sqlite3
- **フォント**: Noto Sans CJK
- **Python 3**: pandas, numpy, scipy, scikit-learn, networkx, openpyxl, xlsxwriter, python-pptx, lxml, pdfplumber, pikepdf, pymupdf, reportlab, weasyprint, pillow, matplotlib, seaborn, plotly, kaleido, requests, beautifulsoup4, jinja2, pyyaml, tabulate, chardet, markdown, rich
- **Node.js 24**: nodejs, npm

## 実行コマンド

```
${CLAUDE_SKILL_DIR}/scripts/toolbox [--dir <path>]... [--root] [--commit] [--memory <size>] <command> [args...]
```

- `--dir <path>`: 追加ディレクトリをマウントする（指定順に `/work/dir1`, `/work/dir2`, ...）
- `--root`: root 権限で実行する（パッケージのインストール等に必要）
- `--commit`: コマンド実行後にイメージを更新する（docker commit）
- `--memory <size>`: メモリ上限を指定する（例: `4g`, `512m`）。通常は不要で、メモリ不足で失敗したときに使用する


実行例:
```bash
${CLAUDE_SKILL_DIR}/scripts/toolbox python3 script.py arg1 arg2
${CLAUDE_SKILL_DIR}/scripts/toolbox pdftotext input.pdf output.txt
${CLAUDE_SKILL_DIR}/scripts/toolbox ffmpeg -i input.mp4 output.gif
```

ヒアドキュメントで標準入力からコードを渡すこともできる:
```bash
${CLAUDE_SKILL_DIR}/scripts/toolbox python3 - <<'PYTHON'
print("Hello")
PYTHON
```

## ファイルパスの注意

ホスト側の絶対パス（例: `/Users/.../file.csv`）はコンテナ内に存在しないため使えない。

カレントディレクトリは常に `/work/pwd` にマウントされる。
コンテナの作業ディレクトリは `/work/pwd` なので、相対パスでそのままアクセスできる。

カレントディレクトリ外のファイルを扱う場合は `--dir` で追加マウントする（指定順に `/work/dir1`, `/work/dir2`, ...）:
```bash
${CLAUDE_SKILL_DIR}/scripts/toolbox --dir /path/to/input --dir /path/to/output python3 - <<'PYTHON'
import pandas as pd
df = pd.read_csv("/work/dir1/data.csv")
df.to_excel("/work/dir2/result.xlsx")
PYTHON
```

## ツールの追加インストール

プリインストール済みのツール以外も追加されている場合がある。インストール前にコマンドの存在を確認する:
```bash
${CLAUDE_SKILL_DIR}/scripts/toolbox which cowsay
```

追加インストールしたツールを永続化するには `--commit` を使用する:
```bash
${CLAUDE_SKILL_DIR}/scripts/toolbox --root --commit bash -c "apt-get update && apt-get install -y パッケージ名 && rm -rf /var/lib/apt/lists/*"
${CLAUDE_SKILL_DIR}/scripts/toolbox --root --commit pip install パッケージ名
```

## イメージの再ビルド

追加インストールをリセットしてプリインストール状態に戻したい場合、再ビルドする:
```bash
${CLAUDE_SKILL_DIR}/scripts/rebuild
```

## 日本語フォント

コンテナには Noto Sans CJK がインストール済み。matplotlib で日本語を使う場合:
```python
matplotlib.rcParams['font.family'] = 'Noto Sans CJK JP'
```
