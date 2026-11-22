# Experiment 9 – Fork-and-Pull-Request Workflow

**Tool:** Git/GitHub  **CO:** CO3

## Aim
Contribute to someone else's repository without write access: fork → clone → branch → change → push → pull request → review → merge.

## Procedure (GitHub)
| # | Step | Command / action |
|---|---|---|
| 1 | Fork a public repo | GitHub → **Fork** |
| 2 | Clone your fork | `git clone https://github.com/<you>/<repo>.git && cd <repo>` |
|   | Link the original | `git remote add upstream https://github.com/<owner>/<repo>.git` |
| 3 | Branch | `git switch -c feature/add-multiply` |
| 4 | Change | edit files (add a function, fix a bug, update README) |
| 5 | Commit & push | `git add . && git commit -m "feat: add multiply()" && git push -u origin feature/add-multiply` |
| 6 | Pull request | GitHub → **Compare & pull request** (base: `owner/main`, compare: `you/feature/add-multiply`) |
| 7 | Review | Reviewer comments inline; use *Review changes → Request changes / Approve* |
| 8 | Respond | Commit more changes on the same branch and `git push`; the PR updates itself |
| 9 | Merge | Maintainer clicks **Merge pull request** |
| 10 | Summary | Submit the PR link + a short summary of the changes and the collaboration |

Keep your fork current: `git fetch upstream && git switch main && git merge upstream/main && git push`.

## Run the offline replay
```bash
bash demo.sh      # uses local bare repos as 'upstream' and 'fork'
```

## Summary template (submission)
*Forked `<owner>/<repo>`, added `multiply()`, opened PR #N. The reviewer asked for a docstring; I added it in a second commit.
The PR was approved and merged by the maintainer. PR link: …*
