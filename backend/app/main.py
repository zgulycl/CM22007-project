from fastapi import FastAPI

from app.version import read_version

app = FastAPI(title="CM22007 API", version=read_version())


@app.get("/health")
def health() -> dict[str, str]:
    """Report that the API is up and able to serve requests."""
    return {"status": "ok"}
