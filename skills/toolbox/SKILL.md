---
name: toolbox
description: 一時的な作業でローカル環境にないツールをDockerコンテナで実行する。Python、PDF操作、画像変換、データ処理、スクレイピングなど用途を問わない。
---

# Toolbox

ローカル環境にないツールやコマンドを使いたい場合、必ずDockerコンテナ（toolbox）で実行すること。

プロジェクト自体のコード（テスト、lint、アプリ起動など）はプロジェクトの環境で実行する。

## プリインストール済みツール

- **Python 3**: pandas, numpy, scipy, matplotlib, seaborn, plotly, openpyxl, xlsxwriter, pillow, requests, beautifulsoup4, pdfplumber, python-pptx, lxml, jinja2, pyyaml, tabulate, chardet, kaleido
- **PDF**: poppler-utils (pdftotext, pdfimages, pdftoppm), ghostscript, qpdf
- **画像・動画**: ffmpeg, imagemagick
- **基本ツール**: curl, wget, jq, git, zip, unzip, file

## 実行コマンド

```
${CLAUDE_SKILL_DIR}/scripts/toolbox [--dir <path>]... [--root] [--commit] <command> [args...]
```

- `--dir <path>`: 追加ディレクトリをマウントする（指定順に `/work/dir1`, `/work/dir2`, ...）
- `--root`: root 権限で実行する（パッケージのインストール等に必要）
- `--commit`: コマンド実行後にイメージを更新する（docker commit）
- 上記以外の引数はそのまま `docker run` に渡される

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

追加インストールしたツールを永続化するには `--commit` を使用する:
```bash
${CLAUDE_SKILL_DIR}/scripts/toolbox --root --commit bash -c "apt-get update && apt-get install -y パッケージ名 && rm -rf /var/lib/apt/lists/*"
${CLAUDE_SKILL_DIR}/scripts/toolbox --root --commit pip install パッケージ名
```

## 日本語フォント

コンテナには Noto Sans CJK がインストール済み。matplotlib で日本語を使う場合:
```python
matplotlib.rcParams['font.family'] = 'Noto Sans CJK JP'
```

## ルール

- コードは標準入力（ヒアドキュメント）で渡すことを優先する
- プロジェクト自体のコード実行にはこのスキルを使わない
