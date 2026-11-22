# Experiment 20 – Create a GitHub Repository, Clone, Edit README, Push

**Tool:** Git/GitHub  **CO:** CO3

```bash
# 1. GitHub → New repository → name: personal-project → tick "Add a README file" → Create
# 2. clone
git clone https://github.com/<you>/personal-project.git
cd personal-project
# 3. edit README.md (add description / usage)
# 4. stage, commit, push
git status
git add README.md
git commit -m "docs: add project description"
git push origin main
```
Refresh the GitHub page: the README shows your description and the commit appears in the history.

Authentication: HTTPS needs a **personal access token** as password (or use `gh auth login` / SSH keys).

First-time setup: `git config --global user.name "Your Name"` · `git config --global user.email "you@example.com"`.

Offline replay: `bash demo.sh`.
