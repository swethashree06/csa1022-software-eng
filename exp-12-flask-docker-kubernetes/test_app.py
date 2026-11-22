import app as app_module


def client():
    return app_module.app.test_client()


def test_home():
    r = client().get("/")
    assert r.status_code == 200 and "Hello" in r.get_json()["message"]


def test_health():
    assert client().get("/health").get_json() == {"status": "ok"}


def test_add_and_list_items():
    c = client()
    r = c.post("/items", json={"name": "eraser"})
    assert r.status_code == 201
    assert any(i["name"] == "eraser" for i in c.get("/items").get_json())


def test_add_item_validation():
    assert client().post("/items", json={}).status_code == 400
