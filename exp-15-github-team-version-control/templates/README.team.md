# Team Project

## Modules
| Module | Owner | Branch |
|---|---|---|
| Authentication | @memberA | `feature/auth` |
| Payments | @memberB | `feature/payments` |
| UI | @memberC | `feature/ui` |

## Workflow
1. `git switch main && git pull`
2. `git switch -c feature/<module>`
3. Commit often, push, open a pull request to `main`
4. One reviewer approves → **Squash and merge**
5. If GitHub reports conflicts: `git fetch && git merge origin/main`, resolve, commit, push

## Commit message style
`feat(auth): add login endpoint` · `fix(ui): correct button alignment` · `docs: update README`
