# gitworktree-skill

This repo contains a Codex skill that captures a fast Git worktree workflow
using the `ga` and `gd` helpers to create, switch, and clean isolated branches.

## How to use

1. Install or copy the `gitworktree-skill` directory into your Codex skills path.
2. If `ga`/`gd` are not available, install the helpers:

```bash
source scripts/worktree_helpers.sh
```

3. Optional dependencies:
   - `gum` (required by `gd`): `brew install gum`
   - `mise` (optional, for auto trust): `brew install mise`
4. Start a Codex session in a repo where you want to use worktrees.
5. Ask for isolated feature/fix work and use the commands below.

### Commands

```bash
ga <branch-name>     # create worktree + branch and cd into it
gd                  # delete current worktree (requires gum)
git worktree list   # list all worktrees
```

### Example

```bash
ga feature/new-api
```
