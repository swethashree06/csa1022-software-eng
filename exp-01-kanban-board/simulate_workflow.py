#!/usr/bin/env python3
"""Simulate moving tasks across a Kanban board (To Do -> In Progress -> Done) and print the board after every move.

Usage: python simulate_workflow.py [board.json]
Enforces a WIP limit on the In Progress column, the core Kanban rule.
"""
import copy
import json
import sys
from pathlib import Path

WIP_LIMIT = 3
ORDER = ["To Do", "In Progress", "Done"]


def load(path):
    return json.loads(Path(path).read_text())


def column(board, name):
    return next(c for c in board["columns"] if c["name"] == name)


def move(board, task_id, target):
    src = next(c for c in board["columns"] if any(t["id"] == task_id for t in c["tasks"]))
    if ORDER.index(target) != ORDER.index(src["name"]) + 1:
        raise ValueError(f"{task_id}: cannot move {src['name']} -> {target}")
    if target == "In Progress" and len(column(board, target)["tasks"]) >= WIP_LIMIT:
        raise ValueError(f"WIP limit ({WIP_LIMIT}) reached; finish something first")
    task = next(t for t in src["tasks"] if t["id"] == task_id)
    src["tasks"].remove(task)
    column(board, target)["tasks"].append(task)


def render(board, title):
    print(f"\n=== {title} ===")
    for c in board["columns"]:
        ids = ", ".join(t["id"] for t in c["tasks"]) or "-"
        print(f"  {c['name']:<12} ({len(c['tasks'])}): {ids}")


def main():
    path = sys.argv[1] if len(sys.argv) > 1 else Path(__file__).with_name("board.json")
    board = copy.deepcopy(load(path))
    render(board, "Initial board")
    steps = [
        ("KAN-1", "In Progress"), ("KAN-2", "In Progress"), ("KAN-3", "In Progress"),
        ("KAN-1", "Done"), ("KAN-4", "In Progress"),
        ("KAN-2", "Done"), ("KAN-3", "Done"), ("KAN-4", "Done"),
    ]
    for tid, target in steps:
        move(board, tid, target)
        render(board, f"Moved {tid} -> {target}")
    try:
        move(board, "KAN-5", "Done")
    except ValueError as e:
        print(f"\nExpected rejection: {e}")


if __name__ == "__main__":
    main()
