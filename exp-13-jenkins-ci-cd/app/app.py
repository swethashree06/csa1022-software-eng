from flask import Flask, jsonify

app = Flask(__name__)


def add(a, b):
    return a + b


@app.get("/")
def index():
    return jsonify(service="jenkins-demo", sum=add(2, 3))


@app.get("/health")
def health():
    return jsonify(status="ok")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
