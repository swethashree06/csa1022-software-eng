# Experiment 6 – Linking Jira with Confluence (Library Management System)

**Tools:** Jira & Confluence  **CO:** CO2

## Aim
Create a Confluence page "Library Management System Project Overview" that embeds ≥5 Jira issues with their live status and a
progress indicator.

## Prerequisites
Atlassian Cloud site with Jira + Confluence; a Jira project `LMS` containing the issues in `jira-issues.csv`
(import them via *CSV import*). Use `Done`, `In Progress` and `To Do` statuses.

## Procedure
1. Confluence → **Create** → **Page** → title **Library Management System Project Overview**.
2. Type `/jira` and choose **Jira Issues** → paste the JQL from `confluence-page.md` → **Insert**. Choose the columns *Key, Summary, Status*.
3. (If the sprint is not active) use `project = LMS ORDER BY key` instead.
4. Add the progress view: type `/jira` → **Jira Chart** → *Pie chart*, statistic *Status*, same JQL (shows Done / In Progress / To Do share). For an explicit bar add a heading *Progress: 33%* and a **Status** lozenge, or a Marketplace *Progress Tracker* macro.
5. **Publish** and take a screenshot showing the embedded issues and the progress bar.
6. Change an issue's status in Jira → refresh the page → the macro updates (this proves the integration).

## Files
* `confluence-page.md` – page text, JQL, sample table and progress bar
* `page-preview.html` – local HTML rendering of the finished page (open in a browser)
* `jira-issues.csv` – six issues to import into Jira
* `screenshots/` – `01-confluence-page.png`

Sample progress: **2/6 done = 33%**.
