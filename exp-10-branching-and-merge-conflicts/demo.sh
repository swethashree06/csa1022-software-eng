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

step "Shared repository with a teammate"
git init -q --bare origin.git
git clone -q origin.git me 2>/dev/null
( cd me && printf '# Greeter\n\ngreeting = "Hello"\n' > app.py && git add . && git commit -qm "Initial app" && git push -q origin main )

step "1. Clone the shared repo (second clone = teammate)"
git clone -q origin.git teammate
git clone -q origin.git "$SB/me2" && cd "$SB/me2"

step "2. Create a branch and switch to it"
git switch -q -c feature/greeting-me

step "3-4. Change a file and commit"
printf '# Greeter\n\ngreeting = "Hi from my feature branch"\n' > app.py
git commit -qam "feat: friendlier greeting"

step "5. Push the branch"
git push -q -u origin feature/greeting-me

step "Meanwhile the teammate changes the SAME line on main"
( cd ../teammate
  printf '# Greeter\n\ngreeting = "Hello, team!"\n' > app.py
  git commit -qam "feat: team greeting" && git push -q origin main )

step "6. Pull latest main (git fetch)"
git fetch -q origin

step "7-8. Merge main into the feature branch -> CONFLICT"
if git merge origin/main -m "Merge main into feature/greeting-me"; then echo "no conflict?!"; exit 1; fi
git status --short
echo "--- conflict markers ---"; cat app.py

step "9. Resolve manually (keep both ideas) and mark resolved"
printf '# Greeter\n\ngreeting = "Hello, team! Hi from my feature branch"\n' > app.py
git add app.py

step "10. Commit the resolved merge"
git commit -qm "Merge origin/main into feature/greeting-me (resolve greeting conflict)"

step "11. Push the merged feature branch (then open the Pull Request)"
git push -q origin feature/greeting-me

step "Maintainer merges the approved PR into main"
git -C ../teammate pull -q origin main
git -C ../teammate merge -q --ff-only origin/feature/greeting-me 2>/dev/null || git -C ../teammate fetch -q && git -C ../teammate merge -q --ff-only origin/feature/greeting-me
git -C ../teammate push -q origin main
git -C ../teammate log --oneline --graph --all
grep -q "Hi from my feature branch" ../teammate/app.py && echo "OK: conflict resolved and merged"
