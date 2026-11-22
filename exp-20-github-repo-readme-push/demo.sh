#!/usr/bin/env bash
# Offline replay: local bare repositories play the role of GitHub. Needs only git.
set -euo pipefail
export GIT_AUTHOR_NAME="Lab Student" GIT_AUTHOR_EMAIL="student@example.com"
export GIT_COMMITTER_NAME="Lab Student" GIT_COMMITTER_EMAIL="student@example.com"
export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_SYSTEM=/dev/null
HERE="$(cd "$(dirname "$0")" && pwd)"
SB="$HERE/.sandbox"; rm -rf "$SB"; mkdir -p "$SB"; cd "$SB"
step() { printf '\n\033[1;34m### %s\033[0m\n' "$*"; }
git() { command git -c init.defaultBranch=main -c core.editor=true -c pull.rebase=false "$@"; }

step "1. Create a GitHub repository with a README (bare repo = GitHub)"
git init -q --bare personal-project.git
git clone -q personal-project.git seed 2>/dev/null
( cd seed && echo "# personal-project" > README.md && git add . && git commit -qm "Initial commit" && git push -q origin main )

step "2. Clone to local machine"
git clone -q personal-project.git local && cd local

step "3. Edit README.md (project description)"
cat >> README.md <<'MD'

## Description
A small personal project created for the CSA10 Software Engineering lab.

## Usage
Run `python main.py`.
MD

step "4. Stage, commit, push"
git status --short
git add README.md
git commit -qm "docs: add project description"
git push -q origin main
git log --oneline
test "$(git rev-parse HEAD)" = "$(git --git-dir=../personal-project.git rev-parse main)" && echo "OK: remote == local"
