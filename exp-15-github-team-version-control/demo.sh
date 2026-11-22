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

step "Team repository (bare = GitHub)"
git init -q --bare team.git
git clone -q team.git lead 2>/dev/null
( cd lead
  mkdir auth payments ui
  echo "# Team Project" > README.md; echo "# auth" > auth/auth.py; echo "# pay" > payments/pay.py; echo "# ui" > ui/ui.py
  git add . && git commit -qm "chore: project skeleton" && git push -q origin main )

for m in auth payments ui; do
  step "Module branch feature/$m (cloned by its owner)"
  git clone -q team.git "dev-$m"
  ( cd "dev-$m"
    git switch -q -c "feature/$m"
    echo "def $m(): return '$m ready'" >> "$m/$( [ $m = auth ] && echo auth || ([ $m = payments ] && echo pay || echo ui) ).py"
    echo "- $m module done" >> README.md
    git commit -qam "feat($m): implement module"
    git push -q -u origin "feature/$m" )
done

merge_pr() {  # simulate: review approved -> squash merge on GitHub
  ( cd lead && git pull -q origin main && git fetch -q origin "feature/$1" )
  if ! ( cd lead && git merge --squash "origin/feature/$1" >/dev/null 2>&1 ); then
    echo "!! conflict while merging feature/$1 -> resolving (keep both lines)"
    ( cd lead && sed -i '/^<<<<<<<\|^=======\|^>>>>>>>/d' README.md && git add README.md )
  fi
  ( cd lead && git commit -qm "feat($1): squash merge PR for $1" && git push -q origin main )
}
step "Merge pull requests one by one (README.md conflicts because every module edits the last line)"
for m in auth payments ui; do merge_pr "$m"; done
cd lead && git log --oneline && cat README.md
grep -q "ui module done" README.md && grep -q "auth module done" README.md && echo "OK: all modules merged"
