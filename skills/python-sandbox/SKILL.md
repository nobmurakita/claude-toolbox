---
name: python-sandbox
description: プロジェクトのコード実行ではなく、一時的なPythonスクリプトを実行する場合に使用する。データ処理、ファイル変換、リソース生成、スクレイピングなど用途を問わない。
---

# Python Sandbox

プロジェクトのコード実行ではない一時的なPythonスクリプトは、
システムのPythonやプロジェクトの仮想環境を使わず、
必ずDockerコンテナ（python-sandbox）で実行すること。

プロジェクト自体のコード（テスト、lint、アプリ起動など）はプロジェクトの環境で実行する。

`/python-sandbox` に引数が渡された場合: $ARGUMENTS
- `.py` ファイルパスで始まる場合 → そのファイルをコンテナで実行する（後続の引数はスクリプトの引数として渡す）
- それ以外の場合 → タスクの指示として解釈し、コードを書いて実行する

## 実行コマンド

標準入力でコードを渡す:
```bash
${CLAUDE_SKILL_DIR}/scripts/python-sandbox <<'PYTHON'
print("Hello")
PYTHON
```

スクリプトファイルを実行する:
```bash
${CLAUDE_SKILL_DIR}/scripts/python-sandbox script.py input.csv output.xlsx
```

追加ライブラリが必要な場合:
```bash
${CLAUDE_SKILL_DIR}/scripts/python-sandbox --pip requests <<'PYTHON'
import requests
print(requests.get("https://example.com").status_code)
PYTHON
```

## プリインストール済みパッケージ

`--pip` を使う前に、既にインストール済みか確認すること:
```bash
${CLAUDE_SKILL_DIR}/scripts/python-sandbox --list
```

## 日本語フォント

コンテナには Noto Sans CJK がインストール済み。matplotlibで日本語を使う場合:
```python
matplotlib.rcParams['font.family'] = 'Noto Sans CJK JP'
```

## ルール

- コードは標準入力（ヒアドキュメント）で渡し、スクリプトファイルを作成しない
- 追加インストールしたライブラリは `python-sandbox-packages` ボリュームに永続化される
- プロジェクト自体のコード実行にはこのスキルを使わない
