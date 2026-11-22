#!/usr/bin/env python3
"""Rebuild library-moscow.xlsx from library-moscow.csv (needs openpyxl)."""
import csv
from pathlib import Path
from openpyxl import Workbook
from openpyxl.styles import Alignment, Font, PatternFill

here = Path(__file__).parent
wb = Workbook()
ws = wb.active
ws.title = "MoSCoW"
for row in csv.reader((here / "library-moscow.csv").open()):
    ws.append(row)
for c in ws[1]:
    c.font = Font(bold=True, color="FFFFFF")
    c.fill = PatternFill("solid", fgColor="1F4E78")
for row in ws.iter_rows(min_row=2):
    for c in row:
        c.alignment = Alignment(wrap_text=True, vertical="top")
for col, width in zip("ABCDEF", [6, 44, 16, 22, 22, 70]):
    ws.column_dimensions[col].width = width
wb.save(here / "library-moscow.xlsx")
print("written", here / "library-moscow.xlsx")
