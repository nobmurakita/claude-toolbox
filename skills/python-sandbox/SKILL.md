---
name: python-sandbox
description: プロジェクトのコード実行ではなく、一時的なPythonスクリプトを実行する場合に使用する。データ処理、ファイル変換、リソース生成、スクレイピングなど用途を問わない。
---

# Python Sandbox

プロジェクトのコード実行ではない一時的なPythonスクリプトは、
システムのPythonやプロジェクトの仮想環境を使わず、
必ずDockerコンテナ（python-sandbox）で実行すること。

プロジェクト自体のコード（テスト、lint、アプリ起動など）はプロジェクトの環境で実行する。

## 実行コマンド

```bash
docker run --rm \
  -v "$(pwd)":/workspace \
  -v claude-python-sandbox-packages:/usr/local/lib/python3.13/site-packages \
  python-sandbox \
  python script.py
```

## 追加ライブラリが必要な場合

```bash
docker run --rm \
  -v "$(pwd)":/workspace \
  -v claude-python-sandbox-packages:/usr/local/lib/python3.13/site-packages \
  python-sandbox \
  bash -c "pip install <ライブラリ名> && python script.py"
```

## ルール

- スクリプトはカレントディレクトリに作成する
- 出力ファイルも `/workspace`（カレントディレクトリ）に保存する
- 追加インストールしたライブラリは `claude-python-sandbox-packages` ボリュームに永続化される
- プロジェクト自体のコード実行にはこのスキルを使わない
