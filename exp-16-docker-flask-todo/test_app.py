import pytest

import app as m


@pytest.fixture()
def c():
    m.TODOS.clear()
    return m.app.test_client()


def test_create_and_list(c):
    r = c.post("/todos", json={"title": "Buy milk"})
    assert r.status_code == 201
    assert [t["title"] for t in c.get("/todos").get_json()] == ["Buy milk"]


def test_validation(c):
    assert c.post("/todos", json={"title": "  "}).status_code == 400


def test_toggle_update_delete(c):
    tid = c.post("/todos", json={"title": "x"}).get_json()["id"]
    assert c.put(f"/todos/{tid}", json={"toggle": True}).get_json()["done"] is True
    assert c.put(f"/todos/{tid}", json={"title": "y"}).get_json()["title"] == "y"
    assert c.delete(f"/todos/{tid}").status_code == 204
    assert c.delete(f"/todos/{tid}").status_code == 404


def test_index_and_health(c):
    assert b"To-Do" in c.get("/").data
    assert c.get("/health").status_code == 200
