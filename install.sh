#!/bin/bash
set -e

REPO="https://raw.githubusercontent.com/nobmurakita/claude-python-sandbox/main"

# Dockerの確認
if ! command -v docker &> /dev/null; then
  echo "❌ Dockerがインストールされていません" >&2
  exit 1
fi
if ! docker info &> /dev/null; then
  echo "❌ Dockerデーモンが起動していません" >&2
  exit 1
fi

echo "📦 claude-python-sandbox をインストールします..."

# SKILL.md をインストール
mkdir -p ~/.claude/skills/python-sandbox
curl -fsSL "$REPO/skills/python-sandbox/SKILL.md" \
  -o ~/.claude/skills/python-sandbox/SKILL.md
echo "✅ SKILL.md をインストールしました"

# 実行スクリプトをインストール
curl -fsSL "$REPO/skills/python-sandbox/scripts/python-sandbox" \
  -o ~/.claude/skills/python-sandbox/scripts/python-sandbox
chmod +x ~/.claude/skills/python-sandbox/scripts/python-sandbox
echo "✅ python-sandbox スクリプトをインストールしました"

# Dockerfile をインストール
mkdir -p ~/.claude-python-sandbox
curl -fsSL "$REPO/docker/Dockerfile" \
  -o ~/.claude-python-sandbox/Dockerfile
echo "✅ Dockerfile をインストールしました"

# Dockerイメージをビルド
echo "🐳 Dockerイメージをビルドしています..."
if docker buildx version &> /dev/null; then
  docker buildx build -t python-sandbox ~/.claude-python-sandbox
else
  docker build -t python-sandbox ~/.claude-python-sandbox
fi
echo "✅ Dockerイメージをビルドしました"

echo "🎉 インストール完了！"
