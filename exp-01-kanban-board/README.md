# Experiment 1 – Kanban Board

**Tools:** Jira or Trello  **CO:** CO1

## Aim
Create a Kanban board that visualises work, with columns **To Do**, **In Progress** and **Done**, add at least five sample
tasks and move them across the columns to simulate a workflow.

## Files
| File | Purpose |
|---|---|
| `tasks.csv` | 6 sample tasks – import into Jira (*Settings → System → External System Import → CSV*) or Trello (*Power-Up CSV Importer*) |
| `board.json` | The board definition (columns + tasks) |
| `simulate_workflow.py` | Offline simulation that moves tasks and enforces a WIP limit, printing the board after each move |
| `screenshots/` | Put your screenshots here |

## Procedure – Trello
1. Sign in at trello.com → **Create new board** → name it *SE Lab – Kanban Board*.
2. Add three lists: **To Do**, **In Progress**, **Done**.
3. In *To Do* add six cards (see `tasks.csv`): set a member, label (priority) and due date on each.
4. Drag KAN-1, KAN-2, KAN-3 into *In Progress*; later drag KAN-1 into *Done*. Continue until the workflow is exercised.
5. Screenshot the board at each stage.

## Procedure – Jira
1. **Create project → Kanban** (company-managed) → name *SE Lab Kanban*.
2. Board → **Columns** shows *To Do / In Progress / Done* by default. Optionally set *Max* on In Progress = 3 (WIP limit).
3. **Create** 6 issues (Task type) from `tasks.csv`.
4. Drag cards between columns; screenshot each stage.

## Run the simulation
```bash
python3 simulate_workflow.py
```

## Expected result
A board with ≥5 cards that have travelled To Do → In Progress → Done; the WIP limit prevents a 4th card entering
*In Progress*.

## Viva points
* Kanban = visualise work, limit WIP, manage flow, continuous delivery (no fixed sprints).
* Cards have exactly one column; columns map to workflow states.
