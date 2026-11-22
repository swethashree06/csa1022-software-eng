"""Simple Flask API used for Docker + Kubernetes deployment."""
import os
import socket

from flask import Flask, jsonify, request

app = Flask(__name__)

ITEMS = [{"id": 1, "name": "notebook"}, {"id": 2, "name": "pen"}]


@app.get("/")
def home():
    return jsonify(message="Hello from Flask on Kubernetes!", pod=socket.gethostname())


@app.get("/health")
def health():
    return jsonify(status="ok")


@app.get("/items")
def list_items():
    return jsonify(ITEMS)


@app.post("/items")
def add_item():
    data = request.get_json(silent=True) or {}
    name = str(data.get("name", "")).strip()
    if not name:
        return jsonify(error="name is required"), 400
    item = {"id": max((i["id"] for i in ITEMS), default=0) + 1, "name": name}
    ITEMS.append(item)
    return jsonify(item), 201


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
