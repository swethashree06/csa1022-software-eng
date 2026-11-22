from app import app


def test_index():
    assert app.test_client().get("/").status_code == 200


def test_add():
    assert app.test_client().get("/add/2/3").get_json() == {"result": 5}


def test_health():
    assert app.test_client().get("/health").get_json()["status"] == "ok"
