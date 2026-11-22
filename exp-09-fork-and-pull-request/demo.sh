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

step "0. Maintainer's public repository (stands in for github.com/upstream-owner/sample-project)"
git init -q --bare upstream.git
git clone -q upstream.git seed 2>/dev/null
( cd seed
  printf '# Sample Project\n' > README.md
  printf 'def add(a, b):\n    return a + b\n' > calc.py
  git add . && git commit -qm "Initial commit" && git push -q origin main )

step "1. Fork (on GitHub: Fork button) -> a server-side copy owned by you"
git clone -q --bare upstream.git fork.git

step "2. Clone your fork"
git clone -q fork.git work && cd work
git remote add upstream ../upstream.git
git remote -v

step "3. Create a feature branch"
git switch -q -c feature/add-multiply

step "4. Make the change and 5. commit + push the branch to your fork"
printf '\n\ndef multiply(a, b):\n    return a * b\n' >> calc.py
git commit -qam "feat: add multiply()"
git push -q -u origin feature/add-multiply

step "6. Open pull request (GitHub UI): base=upstream:main <- compare=fork:feature/add-multiply"
echo "PR contains:"; git log --oneline upstream/main..HEAD 2>/dev/null || git log --oneline -1

step "7. Reviewer leaves feedback: 'please add a docstring'"
echo "8. Respond with an additional commit on the same branch (PR updates automatically)"
python3 - <<'PY'
import re
s = open("calc.py").read()
s = s.replace("def multiply(a, b):\n", 'def multiply(a, b):\n    """Return the product of a and b."""\n')
open("calc.py", "w").write(s)
PY
git commit -qam "docs: add docstring to multiply()"
git push -q origin feature/add-multiply

step "9. PR approved -> maintainer merges into main"
git -C ../seed pull -q origin main
git -C ../seed fetch -q ../fork.git feature/add-multiply
git -C ../seed merge -q --no-ff FETCH_HEAD -m "Merge pull request #1 from fork/feature/add-multiply"
git -C ../seed push -q origin main

step "10. Sync your fork with upstream"
git fetch -q upstream && git switch -q main && git merge -q --ff-only upstream/main && git push -q origin main
git log --oneline --graph --all
test "$(grep -c multiply calc.py)" -ge 1 && echo "OK: feature is on main"
