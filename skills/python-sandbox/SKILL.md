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
docker run --rm -i \
  -v claude-python-sandbox-packages:/usr/local/lib/python3.14/site-packages \
  python-sandbox \
  python - <<'PYTHON'
print("Hello")
PYTHON
```

## ファイル入出力が必要な場合

```bash
docker run --rm -i \
  -v "$(pwd)":/workspace \
  -v claude-python-sandbox-packages:/usr/local/lib/python3.14/site-packages \
  python-sandbox \
  python - <<'PYTHON'
import pandas as pd
df = pd.read_csv("/workspace/data.csv")
df.to_excel("/workspace/output.xlsx", index=False)
PYTHON
```

## 追加ライブラリが必要な場合

```bash
docker run --rm -i \
  -v claude-python-sandbox-packages:/usr/local/lib/python3.14/site-packages \
  python-sandbox \
  bash -c "pip install <ライブラリ名> && python -" <<'PYTHON'
print("Hello")
PYTHON
```

## ルール

- コードは標準入力（ヒアドキュメント）で渡し、スクリプトファイルを作成しない
- ファイル入出力が必要な場合のみ `-v "$(pwd)":/workspace` をマウントする
- 追加インストールしたライブラリは `claude-python-sandbox-packages` ボリュームに永続化される
- プロジェクト自体のコード実行にはこのスキルを使わない
