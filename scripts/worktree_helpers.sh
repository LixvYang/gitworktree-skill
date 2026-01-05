#!/usr/bin/env bash

set -euo pipefail

ga() {
  local branch="${1:-}"
  if [[ -z "${branch}" ]]; then
    echo "usage: ga <branch-name>" >&2
    return 2
  fi

  local repo
  repo="$(basename "$(git rev-parse --show-toplevel 2>/dev/null)")"
  if [[ -z "${repo}" ]]; then
    echo "ga: not inside a git repository" >&2
    return 2
  fi

  local target="../${repo}-${branch}"
  git worktree add -b "${branch}" "${target}"
  cd "${target}"
}

gd() {
  local top
  top="$(git rev-parse --show-toplevel 2>/dev/null)" || {
    echo "gd: not inside a git repository" >&2
    return 2
  }

  local repo
  repo="$(basename "${top}")"
  local dir
  dir="$(basename "$PWD")"

  if [[ "${dir}" != "${repo}-"* ]]; then
    echo "gd: current directory is not a worktree (${repo}-<branch>)" >&2
    return 2
  fi

  local branch="${dir#${repo}-}"
  git worktree remove "${top}"
  git branch -D "${branch}"
}
