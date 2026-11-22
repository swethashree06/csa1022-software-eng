# Experiment 10 – Git Branches and Merge Conflicts

**Tool:** Git/GitHub  **CO:** CO3

## Aim
Collaborate using branches and resolve a merge conflict caused by two people editing the same lines.

## Commands
```bash
git clone <shared-repo-url> && cd <repo>      # 1
git switch -c feature/greeting-me             # 2
# edit app.py                                  # 3
git commit -am "feat: friendlier greeting"    # 4
git push -u origin feature/greeting-me        # 5
git fetch origin                              # 6  (or: git switch main && git pull)
git switch feature/greeting-me                # 7
git merge origin/main                         # 8  -> CONFLICT in app.py
```
Conflicted file:
```
<<<<<<< HEAD
greeting = "Hi from my feature branch"
=======
greeting = "Hello, team!"
>>>>>>> origin/main
```
9. Edit the file: choose/combine the lines and **delete the three marker lines**, then `git add app.py` (marks it resolved).
10. `git commit` (accept the default merge message).
11. `git push origin feature/greeting-me`, then create a **Pull Request** on GitHub (feature → main).
12. After approval: **Merge pull request**.

Tools: `git status`, `git diff --name-only --diff-filter=U`, `git mergetool`, `git merge --abort` (to back out).

## Run the offline replay
```bash
bash demo.sh
```

## Summary template
*I cloned the repo, worked on `feature/greeting-me`, and a teammate changed the same line on `main`. Merging `main` produced a conflict in
`app.py`; I kept both messages, staged the file, committed the merge, pushed and opened PR #N which was merged.*
