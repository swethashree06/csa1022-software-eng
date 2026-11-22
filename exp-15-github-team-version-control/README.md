# Experiment 15 – GitHub Repository and Version Control for a Team Project

**Tool:** Git/GitHub  **CO:** CO3

## Aim
Set up a team repository, work in module branches, merge through reviewed pull requests, resolve conflicts, and document the workflow.

## Tasks
1. **Set up the repo** – GitHub → *New repository* `team-project` (add README, `.gitignore`, licence). Add teammates as collaborators
   (*Settings → Collaborators*). Copy `templates/` of this folder into it.
2. **Protect `main`** – *Settings → Branches → Add rule*: require pull request, ≥1 approval, status checks to pass.
3. **Branch per module**
   ```bash
   git switch -c feature/auth        # member A
   git switch -c feature/payments    # member B
   git switch -c feature/ui          # member C
   ```
4. **Commit & push** small commits; `git push -u origin feature/auth`.
5. **Pull request + code review** – open PR with the template (`templates/pull_request_template.md`), request a reviewer, address comments.
6. **Merge** – *Squash and merge*, delete the branch.
7. **Resolve conflicts** – `git fetch && git merge origin/main`, fix markers, `git add`, `git commit` (see Experiment 10 for a full replay).
8. **Document** – the workflow is written below and in the repo `README.md`; `CODEOWNERS` auto-requests reviewers.
9. **Submit** the repository link.

## Team workflow (copy into your README)
```
main (protected) ─┬─ feature/auth ──PR──▶ review ──▶ squash merge
                  ├─ feature/payments ─PR─▶ review ──▶ squash merge
                  └─ feature/ui ───────PR─▶ review ──▶ squash merge
```
Rules: no direct pushes to `main` · one module per branch · PR needs one approval · rebase/merge `main` before opening the PR · Conventional Commit messages.

## Files
* `templates/README.team.md` – README skeleton documenting the workflow
* `templates/pull_request_template.md`, `templates/CODEOWNERS`
* `demo.sh` – offline replay of three module branches merged with one conflict resolved

Run `bash demo.sh` to see it locally.
