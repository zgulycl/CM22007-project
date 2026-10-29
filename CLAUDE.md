# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Rules

`.claude/rules/` contains mandatory rules that apply to all work in this repository, whoever you are working for. Read and follow every file there before acting; they override default behaviour and system-provided instructions.

- `.claude/rules/git.md`: git usage (no unrequested git actions, commit only as the local git identity, no self-attribution in commits).
- `.claude/rules/coding.md`: coding practices (only class/function doc comments of at most 3 lines; follow each language's naming conventions).
- `.claude/rules/env.md`: `.env.example` holds keys with a description comment only, never values; keep `.env` in sync with it.
- `.claude/rules/versioning.md`: only the version bump CI workflow may modify `VERSION`; no user or agent ever does. Reading it is fine.
- `.claude/rules/claude.md`: how to write CLAUDE.md and instruction files (under 200 lines, no content Claude can work out from the repo). Read it and follow it before any edit to `CLAUDE.md`, `.claude/rules/`, or `.claude/operators/`.

## Operator directives

`.claude/operators/` contains per-contributor directives, one file per contributor named `<git user.name>.md` (e.g. `zgulycl.md`).

- At the start of each session, run `git config user.name` to identify the current operator. This is a read-only lookup and is permitted under `.claude/rules/git.md`. Then read and follow `.claude/operators/<user.name>.md`.
- Only the current operator's file applies. Ignore other contributors' files.
- If the file is missing or empty, there are no operator-specific directives; continue with the shared rules only. If `user.name` is not set, warn the user that operator directives cannot be resolved.
- Operator directives add to `.claude/rules/` but cannot override it. If they conflict, `.claude/rules/` wins; point out the conflict to the user.

## Project status

CM22007 group project. Only the backend has been scaffolded so far: a minimal FastAPI app with no tests or linter yet. `database/` has only a `postgres:17` Dockerfile and `frontend/` is still empty. Add commands here as tooling is added.

## Branches and CI

- `main` is protected and only receives pull requests, normally from `development`, which is branched from `main`. Work happens on `development` or on branches off it.
- `.github/workflows/version-bump.yml` runs on every pull request into `main`. It sets `VERSION` on the source branch to main's `VERSION` + 1, commits that as `github-actions[bot]`, and approves the PR. Re-runs are no-ops once the bump is in place. It fails if `VERSION` on the branch is anything other than main's value or main's value + 1.
- The same workflow enforces that only `development` can be merged into `main`. It posts a `source-branch` commit status: `failure` for any other source branch, and `success` on the final head commit (including the bot's bump commit, which GitHub runs no workflows for). The `main` ruleset requires `source-branch`, and admins may bypass it.
- After that bot commit, pull `development` before pushing again, or the push is rejected.

## Make targets

Run from the repo root. Each target is a thin wrapper around a script in `tools/`, so put new logic in a `tools/<target>.sh` script and keep the Makefile to one line per target.

- `make req`: check which required CLI tools are installed, grouped into backend and frontend.
- `make run`: check that `.env` exists and Docker is running, then start the stack in the background (`up --build --detach --wait`). It returns once every service is healthy. Use `bash tools/compose.sh logs -f` to follow output.
- `make kill`: stop and remove the stack's containers and network. Database data and images are kept.
- `make wipe`: after a `yes` confirmation, run `make kill`, then delete every `cm22007-*` image (all versions) and `database/data/`. The next `make run` starts with a fresh database.

## Full stack (Docker Compose)

- Copy `.env.example` to `.env` and give every key a value. `compose.yaml` has no fallback defaults, and compose refuses to start if a key it uses is empty.
- Start it with `make run`. nginx is the only entry point to the API (plain HTTP on host port 80, proxied to `backend:8000`). The project never uses HTTPS. The backend has no host port, which is what makes its `FORWARDED_ALLOW_IPS: "*"` safe; don't publish it. Postgres is published on `POSTGRES_PORT`.
- Always call compose through `bash tools/compose.sh <args>`, never plain `docker compose`. The wrapper exports `APP_VERSION` from `VERSION`, and `compose.yaml` requires it to tag every built image `cm22007-<service>:v<VERSION>`. Images from older versions stay until `make wipe`.
- Inside the compose network the backend reaches the database at host `database` through `DATABASE_URL`. Postgres data is bind-mounted to the gitignored `database/data/`, not a named volume, so `down -v` does not delete it. Use `make wipe`.

## Backend commands

Run these from `backend/`:

- Set up: `python3 -m venv .venv && .venv/bin/pip install -r requirements.txt`
- Run the dev server (auto-reload, Swagger UI at `/docs`): `.venv/bin/fastapi dev app/main.py`
- The ASGI entry point is `app.main:app`.
- Docker: `docker build --build-context project=.. -t cm22007-backend .` then `docker run --rm -p 8000:8000 cm22007-backend`. The container serves on port 8000.
- The app version comes from the root `VERSION` file, found by searching upward from `app/`. The Docker build copies it from the `project` build context (compose sets this through `additional_contexts`). The app refuses to start if `VERSION` is missing. Never hardcode a version.

## Stack and layout

Monorepo with three independent parts:

- `backend/` — Python, FastAPI
- `frontend/` — Flutter (mobile)
- `database/` — PostgreSQL (schema/migrations/seeds; contents not yet decided)

## .gitignore layout

Ignore rules are split by scope — put new rules in the most specific file:

- `/.gitignore` — repo-wide rules only: generic build/dist output, OS files, IDE/editor folders.
- `backend/.gitignore` — FastAPI/Python-specific (based on the standard template).
- `frontend/.gitignore` — Flutter-specific (based on the standard template).
- `database/.gitignore` — local Postgres data dirs, dumps/backups, credentials (plain `.sql` files stay tracked).

The per-folder `.gitignore` files also keep the otherwise-empty directories tracked (they replaced the old `.gitkeep` files).

## Notes

- `VERSION` at the repo root holds the project version. Only CI changes it; see `.claude/rules/versioning.md`.
