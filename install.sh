#!/bin/bash
set -e

REPO="https://raw.githubusercontent.com/nobmurakita/claude-sandbox-tools/main"

# Dockerの確認
if ! command -v docker &> /dev/null; then
  echo "❌ Dockerがインストールされていません" >&2
  exit 1
fi
if ! docker info &> /dev/null; then
  echo "❌ Dockerデーモンが起動していません" >&2
  exit 1
fi

echo "📦 sandbox-tools をインストールします..."

# SKILL.md をインストール
mkdir -p ~/.claude/skills/sandbox-tools
curl -fsSL "$REPO/skills/sandbox-tools/SKILL.md" \
  -o ~/.claude/skills/sandbox-tools/SKILL.md
echo "✅ SKILL.md をインストールしました"

# 実行スクリプトをインストール
mkdir -p ~/.claude/skills/sandbox-tools/scripts
curl -fsSL "$REPO/skills/sandbox-tools/scripts/sandbox-tools" \
  -o ~/.claude/skills/sandbox-tools/scripts/sandbox-tools
chmod +x ~/.claude/skills/sandbox-tools/scripts/sandbox-tools
echo "✅ sandbox-tools スクリプトをインストールしました"

# Dockerイメージをビルド
echo "🐳 Dockerイメージをビルドしています..."
TMPDIR=$(mktemp -d)
trap "rm -rf $TMPDIR" EXIT
curl -fsSL "$REPO/docker/Dockerfile" -o "$TMPDIR/Dockerfile"
if docker buildx version &> /dev/null; then
  docker buildx build -t sandbox-tools "$TMPDIR"
else
  docker build -t sandbox-tools "$TMPDIR"
fi
echo "✅ Dockerイメージをビルドしました"

echo "🎉 インストール完了！"
