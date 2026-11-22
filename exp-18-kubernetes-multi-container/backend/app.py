"""Backend API (Flask + PostgreSQL). Stores and lists guestbook messages."""
import os

import psycopg2
from flask import Flask, jsonify, request

app = Flask(__name__)


def conn():
    return psycopg2.connect(
        host=os.environ.get("DB_HOST", "database"),
        dbname=os.environ.get("DB_NAME", "appdb"),
        user=os.environ.get("DB_USER", "appuser"),
        password=os.environ.get("DB_PASSWORD", "apppass"),
    )


def init_db():
    with conn() as c, c.cursor() as cur:
        cur.execute("CREATE TABLE IF NOT EXISTS messages (id SERIAL PRIMARY KEY, text TEXT NOT NULL)")


@app.get("/api/health")
def health():
    return jsonify(status="ok")


@app.get("/api/messages")
def list_messages():
    with conn() as c, c.cursor() as cur:
        cur.execute("SELECT id, text FROM messages ORDER BY id")
        return jsonify([{"id": i, "text": t} for i, t in cur.fetchall()])


@app.post("/api/messages")
def add_message():
    text = str((request.get_json(silent=True) or {}).get("text", "")).strip()
    if not text:
        return jsonify(error="text is required"), 400
    with conn() as c, c.cursor() as cur:
        cur.execute("INSERT INTO messages (text) VALUES (%s) RETURNING id", (text,))
        return jsonify(id=cur.fetchone()[0], text=text), 201


if __name__ == "__main__":
    init_db()
    app.run(host="0.0.0.0", port=5000)
