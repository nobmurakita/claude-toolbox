#!/bin/bash
set -e

REPO="https://raw.githubusercontent.com/nobmurakita/claude-toolbox/main"

# Dockerの確認
if ! command -v docker &> /dev/null; then
  echo "❌ Dockerがインストールされていません" >&2
  exit 1
fi
if ! docker info &> /dev/null; then
  echo "❌ Dockerデーモンが起動していません" >&2
  exit 1
fi

echo "📦 toolbox をインストールします..."

# SKILL.md をインストール
mkdir -p ~/.claude/skills/toolbox
curl -fsSL "$REPO/skills/toolbox/SKILL.md" \
  -o ~/.claude/skills/toolbox/SKILL.md
echo "✅ SKILL.md をインストールしました"

# 実行スクリプトをインストール
mkdir -p ~/.claude/skills/toolbox/scripts
curl -fsSL "$REPO/skills/toolbox/scripts/toolbox" \
  -o ~/.claude/skills/toolbox/scripts/toolbox
chmod +x ~/.claude/skills/toolbox/scripts/toolbox
echo "✅ toolbox スクリプトをインストールしました"

# Dockerイメージをビルド
echo "🐳 Dockerイメージをビルドしています..."
TMPDIR=$(mktemp -d)
trap "rm -rf $TMPDIR" EXIT
curl -fsSL "$REPO/docker/Dockerfile" -o "$TMPDIR/Dockerfile"
if docker buildx version &> /dev/null; then
  docker buildx build -t claude-toolbox "$TMPDIR"
else
  docker build -t claude-toolbox "$TMPDIR"
fi
echo "✅ Dockerイメージをビルドしました"

echo "🎉 インストール完了！"
