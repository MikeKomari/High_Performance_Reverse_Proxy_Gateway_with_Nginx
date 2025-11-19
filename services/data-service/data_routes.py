from fastapi import APIRouter, Depends
from auth import verify_token

router = APIRouter()

dummy_data = [{"id": i, "value": f"Dummy {i}"} for i in range(1, 11)]

@router.get("/api/v1/data/items")
def get_data(user = Depends(verify_token)):
    return dummy_data

@router.post("/api/v1/data/items")
def add_data(item: dict, user = Depends(verify_token)):
    new_id = len(dummy_data) + 1
    entry = {"id": new_id, **item}
    dummy_data.append(entry)
    return entry

@router.get("/")
def health():
    return {"status": "ok", "service": "data"}
