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
curl -fsSL "$REPO/skills/toolbox/scripts/rebuild" \
  -o ~/.claude/skills/toolbox/scripts/rebuild
chmod +x ~/.claude/skills/toolbox/scripts/toolbox ~/.claude/skills/toolbox/scripts/rebuild
echo "✅ スクリプトをインストールしました"

# Dockerfile をインストール
mkdir -p ~/.claude/skills/toolbox/docker
curl -fsSL "$REPO/skills/toolbox/docker/Dockerfile" \
  -o ~/.claude/skills/toolbox/docker/Dockerfile
echo "✅ Dockerfile をインストールしました"

# Dockerイメージをビルド
echo "🐳 Dockerイメージをビルドしています..."
~/.claude/skills/toolbox/scripts/rebuild
echo "✅ Dockerイメージをビルドしました"

echo "🎉 インストール完了！"
