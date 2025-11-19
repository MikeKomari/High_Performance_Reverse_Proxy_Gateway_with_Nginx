from jose import jwt, JWTError
from fastapi import HTTPException, Depends
from fastapi.security import HTTPBearer

JWT_SECRET = "dfa54d0308f8cfd2d051978c241a00d3bee6e1b1d89dcae45416a9cd32b0dbb8"
ALGORITHM = "HS256"

security = HTTPBearer()

def verify_token(credentials = Depends(security)):
    token = credentials.credentials
    try:
        payload = jwt.decode(token, JWT_SECRET, algorithms=[ALGORITHM])
        return payload
    except JWTError:
        raise HTTPException(status_code=401, detail="Invalid or expired token")