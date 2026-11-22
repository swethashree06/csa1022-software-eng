# Experiment 7 – MoSCoW + Kano Prioritisation: Task Management System

**Tool:** Jira  **CO:** CO2

## Requirements (from the question)
1. User login and role assignment · 2. Task creation and assignment · 3. Task prioritisation and deadlines · 4. Progress tracking and reporting

## Techniques
* **MoSCoW** – Must / Should / Could / Won't have.
* **Kano** – *Basic* (expected), *Performance* (more is better), *Excitement* (delighters), *Indifferent*, *Reverse*.
  Classified via a functional/dysfunctional survey (template in sheet **Kano survey template**).

## Procedure in Jira
1. Create a Scrum/Kanban project *Task Manager*.
2. Import `jira-import.csv` (*Settings → System → External system import → CSV*) – map **Labels** to *Labels*, **Priority** to *Priority*.
3. Each issue now carries labels like `moscow-must` and `kano-basic`; use the **Backlog** with filter `labels in (moscow-must)` to see the MVP.
4. Build a dashboard/board **Quick filters**: `Must = labels = moscow-must`, `Delighters = labels = kano-excitement`.
5. Order the backlog: Must + Basic first, then Should + Performance, then Could + Excitement; Won't stay unscheduled.
6. Screenshot the backlog with labels.

## Outcome
| MoSCoW | Features |
|---|---|
| Must | Login, roles, task creation, assignment |
| Should | Priority, deadlines, progress tracking |
| Could | Reports, reminders, dashboard |
| Won't | AI suggestions, dark mode |

Files: `task-management-prioritisation.xlsx|csv`, `jira-import.csv`.
