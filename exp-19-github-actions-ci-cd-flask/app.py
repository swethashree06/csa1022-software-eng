import os

from flask import Flask, jsonify

app = Flask(__name__)


@app.get("/")
def index():
    return jsonify(message="Flask app deployed by a GitHub Actions CI/CD pipeline")


@app.get("/health")
def health():
    return jsonify(status="ok")


@app.get("/add/<int:a>/<int:b>")
def add(a, b):
    return jsonify(result=a + b)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
