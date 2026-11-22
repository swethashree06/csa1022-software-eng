from app import app


def test_index():
    assert app.test_client().get("/").status_code == 200


def test_health():
    assert app.test_client().get("/health").get_json() == {"status": "ok"}
