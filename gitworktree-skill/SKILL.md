---
name: gitworktree-skill
description: Manage Git worktrees with ga/gd helpers to create, switch, and clean isolated branches quickly.
metadata:
  short-description: Fast git worktree workflow
---

# Git Worktree Quick Workflow

## When to Use

Use this skill when you need isolated development for a feature, fix, or experiment and want to avoid frequent branch switching.

## Commands

If `ga`/`gd` are not available, install the helper functions from
`scripts/worktree_helpers.sh` and then use the commands below.

```bash
# Create worktree + branch and cd into it
ga <branch-name>

# Delete current worktree (requires gum for confirmation)
gd

# List all worktrees
git worktree list
```

## Recommended Flow

1. Pick a branch name:
   - `feature/<short-desc>`
   - `fix/<short-desc>`
   - `experiment/<short-desc>`
2. Create the worktree:
   - `ga feature/<short-desc>`
3. Do the work in the new directory.
4. Clean up after merge or abandon:
   - `gd`

## Guardrails

- Only run `gd` inside a worktree directory to avoid deleting the main repo.
- If `gd` fails, install gum: `brew install gum`.
- If a branch already exists, choose a new name or delete the old branch first.

## Install helpers (if needed)

```bash
# From this repo root
source scripts/worktree_helpers.sh
```

Add the `source` line to your shell profile (e.g. `~/.zshrc`) to make `ga`/`gd` available.

Example:

```bash
echo 'source /path/to/gitworktree-skill/scripts/worktree_helpers.sh' >> ~/.zshrc
```

### Dependencies

- `gum` is required for `gd` confirmation prompts.
- `mise` is optional and auto-trusts new worktree directories.
