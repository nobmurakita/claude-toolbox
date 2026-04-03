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
curl -fsSL -H "Cache-Control: no-cache" "$REPO/skills/python-sandbox/SKILL.md" \
  -o ~/.claude/skills/python-sandbox/SKILL.md
echo "✅ SKILL.md をインストールしました"

# Dockerfile をインストール
mkdir -p ~/.claude-python-sandbox
curl -fsSL -H "Cache-Control: no-cache" "$REPO/docker/Dockerfile" \
  -o ~/.claude-python-sandbox/Dockerfile
echo "✅ Dockerfile をインストールしました"

# Dockerイメージをビルド
echo "🐳 Dockerイメージをビルドしています..."
docker buildx build -t python-sandbox ~/.claude-python-sandbox
echo "✅ Dockerイメージをビルドしました"

echo "🎉 インストール完了！"
