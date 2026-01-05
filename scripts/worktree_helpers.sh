#!/usr/bin/env bash

set -euo pipefail

ga() {
  if [[ -z "$1" ]]; then
    echo "Usage: ga <branch-name>" >&2
    return 1
  fi

  local branch="$1"
  local base
  base="$(basename "$PWD")"
  local path="../${base}-${branch}"

  git worktree add -b "$branch" "$path" || return 1
  [[ -n "$(command -v mise)" ]] && mise trust "$path"
  cd "$path" || return 1
  echo "✅ Created worktree and switched to: $path (branch: $branch)"
}

gd() {
  if ! command -v gum >/dev/null 2>&1; then
    echo "❌ gd 需要 gum 来进行确认，请先安装：brew install gum 或查看 https://github.com/charmbracelet/gum"
    return 1
  fi

  if ! gum confirm "🚨 删除当前 worktree 和对应分支？此操作不可恢复！"; then
    echo "❎ 操作已取消"
    return 0
  fi

  local cwd
  cwd="$(pwd)"
  local worktree
  worktree="$(basename "$cwd")"

  local root="${worktree%-*}"
  local branch="${worktree#*-}"

  if [[ "$root" == "$worktree" || "$root" == "$branch" ]]; then
    echo "❌ 当前目录名不符合 worktree 命名规则（应为 repo-branch），已阻止删除"
    return 1
  fi

  cd "../$root" || { echo "❌ 无法切换到主目录"; return 1; }

  git worktree remove "$worktree" --force
  git branch -D "$branch"

  echo "🗑️  已删除 worktree '$worktree' 和分支 '$branch'"
}
