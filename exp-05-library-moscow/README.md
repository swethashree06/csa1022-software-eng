# Experiment 5 – MoSCoW Prioritisation: Library Management System

**Tool:** Google Sheet / Excel  **CO:** CO2

## Aim
Categorise ten requirements as **Must / Should / Could / Won't have**, judged on *impact on users & stakeholders* and
*feasibility (time, budget, resources)*, with a written justification for each.

## Deliverable
* `library-moscow.xlsx` – sheet **MoSCoW** (requirements, scores, category, justification) and sheet **Criteria**
* `library-moscow.csv` – same data, plain text (import into Google Sheets via *File → Import*)

## Result summary
| Category | Requirements |
|---|---|
| **Must have** | R1 Search · R2 Reservation · R6 Librarian dashboard |
| **Should have** | R3 Monthly reports · R4 Overdue e-mails |
| **Could have** | R5 QR scanning · R7 Reviews/ratings · R10 Multi-language |
| **Won't have (now)** | R8 Chatbot · R9 Mobile app |

Regenerate the workbook with `python3 build_xlsx.py` after editing the CSV.
