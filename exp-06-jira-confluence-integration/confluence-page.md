# Library Management System Project Overview

## 1. Purpose
Track development of the Library Management System (search, reservations, dashboards, notifications).

## 2. Sprint issues (Jira macro)
Insert with `/jira` → **Jira Issues** → paste the JQL below → *Insert*:

```
project = LMS AND sprint in openSprints() ORDER BY status ASC, key ASC
```

| Key | Summary | Status |
|---|---|---|
| LMS-1 | Develop book search functionality | Done |
| LMS-2 | Create user login page | Done |
| LMS-3 | Implement book reservation | In Progress |
| LMS-4 | Build librarian dashboard | In Progress |
| LMS-5 | Email overdue notifications | To Do |
| LMS-6 | Generate monthly borrow report | To Do |

## 3. Progress
Completed 2 of 6 issues = **33%**.

```
[██████░░░░░░░░░░░░░░] 33%
```

In Confluence use the **Jira Chart** macro (*Pie chart* by *Status*, same JQL) and/or a *Progress: 33%* line with a Status lozenge.
