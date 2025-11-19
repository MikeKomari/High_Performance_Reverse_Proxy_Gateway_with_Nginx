from fastapi import FastAPI
from data_routes import router as data_router

app = FastAPI()
app.include_router(data_router)