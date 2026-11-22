from flask import Flask, jsonify

app = Flask(__name__)


@app.get("/")
def index():
    return jsonify(message="Deployed automatically by GitHub Actions", version="1.0")


@app.get("/health")
def health():
    return jsonify(status="ok")
