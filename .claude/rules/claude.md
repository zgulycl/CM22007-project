---
paths:
  - "CLAUDE.md"
  - "**/CLAUDE.md"
  - ".claude/rules/**/*.md"
  - ".claude/operators/**/*.md"
---

# Rules for writing CLAUDE.md and instruction files

Follow these rules whenever you create or edit `CLAUDE.md`, a file in `.claude/rules/`, or a file in `.claude/operators/`. They are based on Anthropic's official Claude Code guidance (https://code.claude.com/docs/en/memory and https://code.claude.com/docs/en/best-practices).

## Size

- Keep each CLAUDE.md under 200 lines. Longer files use more context and are followed less reliably.
- If an instruction matters only for part of the codebase, move it into a rule scoped with `paths:` frontmatter. Imports (`@path`) do not reduce context cost, because imported files load in full.

## What belongs

- Only facts Claude needs in every session and could not get by reading the repo, such as build, test, and lint commands (including how to run a single test), conventions that differ from tool defaults, gotchas, and decisions recorded nowhere else.
- Before adding a line, ask: "Could Claude find this by reading the code, and would it actually look?" If yes to both, leave the line out.
- Add a line when Claude makes the same mistake twice, when code review catches something Claude should have known, or when the same correction keeps being repeated.

## What does not belong

- Directory layouts, file-by-file descriptions, dependency lists, and architecture overviews, unless they hold something the code does not show.
- Generic best practices, self-evident instructions, long tutorials, and information that changes often.
- Multi-step procedures. Put those in a skill instead.

## Style

- Group instructions under markdown headings and short bullets. Avoid dense paragraphs.
- Make each instruction concrete enough to check: write "Use 4-space indentation", not "Format code nicely".
- Do not use emphasis (IMPORTANT, MUST, capitals) to fix rules that keep being ignored. If something must happen every time, it needs a hook or a permission rule, not stronger wording.

## Consistency

- Contradicting instructions make Claude's behaviour arbitrary. Before editing, check `CLAUDE.md`, `.claude/rules/`, and `.claude/operators/` for conflicts, and remove anything outdated or contradictory.
- Each rules file covers one topic. When you add or remove a rules file, update the list in `CLAUDE.md` to match.
