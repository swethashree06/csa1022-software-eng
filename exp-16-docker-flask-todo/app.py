"""A simple To-Do list API/UI built with Flask (in-memory storage)."""
import os
from itertools import count

from flask import Flask, jsonify, request

app = Flask(__name__)
_ids = count(1)
TODOS = {}

PAGE = """<!doctype html><title>To-Do</title>
<h1>To-Do list</h1>
<form id=f><input id=t placeholder="New task" required><button>Add</button></form>
<ul id=l></ul>
<script>
async function load(){const r=await (await fetch('/todos')).json();
 l.innerHTML=r.map(x=>`<li>${x.done?'<s>'+x.title+'</s>':x.title}
 <button onclick="tog(${x.id})">toggle</button><button onclick="del(${x.id})">delete</button></li>`).join('')}
async function tog(i){await fetch('/todos/'+i,{method:'PUT',headers:{'Content-Type':'application/json'},body:JSON.stringify({toggle:true})});load()}
async function del(i){await fetch('/todos/'+i,{method:'DELETE'});load()}
f.onsubmit=async e=>{e.preventDefault();await fetch('/todos',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({title:t.value})});t.value='';load()};
load();
</script>"""


@app.get("/")
def index():
    return PAGE


@app.get("/health")
def health():
    return jsonify(status="ok")


@app.get("/todos")
def list_todos():
    return jsonify(list(TODOS.values()))


@app.post("/todos")
def create_todo():
    title = str((request.get_json(silent=True) or {}).get("title", "")).strip()
    if not title:
        return jsonify(error="title is required"), 400
    todo = {"id": next(_ids), "title": title, "done": False}
    TODOS[todo["id"]] = todo
    return jsonify(todo), 201


@app.put("/todos/<int:todo_id>")
def update_todo(todo_id):
    todo = TODOS.get(todo_id)
    if todo is None:
        return jsonify(error="not found"), 404
    data = request.get_json(silent=True) or {}
    if data.get("toggle"):
        todo["done"] = not todo["done"]
    if "title" in data and str(data["title"]).strip():
        todo["title"] = str(data["title"]).strip()
    return jsonify(todo)


@app.delete("/todos/<int:todo_id>")
def delete_todo(todo_id):
    if TODOS.pop(todo_id, None) is None:
        return jsonify(error="not found"), 404
    return "", 204


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
