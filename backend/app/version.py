from pathlib import Path


def read_version() -> str:
    """Return the contents of the nearest VERSION file above this module."""
    for directory in Path(__file__).resolve().parents:
        candidate = directory / "VERSION"
        if candidate.is_file():
            return candidate.read_text().strip()
    raise RuntimeError("VERSION file not found above the backend package")
