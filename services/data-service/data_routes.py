from fastapi import APIRouter, Depends
from datetime import datetime
from auth import verify_token

router = APIRouter()

# Dummy in-memory database
dummy_data = [{"id": i, "value": f"Dummy {i}"} for i in range(1, 11)]

# A version counter so GET response changes when POST happens
data_version = {"version": 1}


@router.get("/api/v1/data/items")
def get_data(user = Depends(verify_token)):
    """
    GET endpoint - This one will be micro-cached by Nginx.
    We include timestamp + version to showcase cache behavior.
    """
    return {
        "version": data_version["version"],
        "timestamp": datetime.utcnow().isoformat(),
        "count": len(dummy_data),
        "items": dummy_data
    }


@router.post("/api/v1/data/items")
def add_data(item: dict, user = Depends(verify_token)):
    """
    POST endpoint - This should bypass the micro-cache.
    Adding new data increments the version counter,
    which also proves cache invalidation visually.
    """
    new_id = len(dummy_data) + 1
    entry = {"id": new_id, **item}
    dummy_data.append(entry)

    # Invalidate logical version to show a fresh GET response
    data_version["version"] += 1

    return {
        "message": "Item added",
        "new_item": entry,
        "new_version": data_version["version"]
    }


@router.get("/")
def health():
    """
    Health check - Should NOT be cached by Nginx.
    """
    return {"status": "ok", "service": "data"}
