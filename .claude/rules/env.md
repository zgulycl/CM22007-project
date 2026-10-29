# Environment file rules

These rules apply to every `.env` and `.env.example` file in this repository.

## `.env.example`

- List keys only. Never give a key a value, not even a default, a placeholder, or an example (`POSTGRES_USER=`, not `POSTGRES_USER=cm22007`).
- Put a one-line `#` comment directly above each key describing what it is for. If the key is optional, say so and name the default the code or compose file falls back to.
- Format:
  ```
  # Password for the PostgreSQL superuser
  POSTGRES_PASSWORD=
  ```
- No inline comments after a key (`KEY= # ...`), because not every parser reads them the same way.

## `.env`

- `.env` holds the real values. It is gitignored and must never be committed.
- Keep `.env` and `.env.example` in sync: when you add, rename, or remove a key in one, do the same in the other.
- Never print secret values in output. Show key names only.
