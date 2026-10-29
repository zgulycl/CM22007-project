# Coding rules

These rules apply to all code you write or edit in this repository, in every language.

## Comments

- The only comments allowed are documentation for a class or function: a Python docstring, a Dart `///` doc comment, or the equivalent in the language being written. Each one must be **at most 3 lines**.
- No other comments are allowed. That means no inline comments, no block comments explaining logic, no section banners or dividers, no commented-out code, and no TODO or FIXME notes.
- Do not write long explanatory comments. If code needs explaining, make it clearer through naming and structure instead.
- Exception: machine-readable directives that tools require, such as a shebang, `# noqa`, `# type: ignore`, or `// ignore:`, are allowed, but keep them to a minimum.

## Naming

Follow the official naming conventions of the language being written:

- **Python:** PEP 8. Use `snake_case` for functions, variables, and modules, `PascalCase` for classes, `UPPER_SNAKE_CASE` for constants, and a leading `_` for internal names.
- **Dart:** Effective Dart. Use `UpperCamelCase` for classes, enums, typedefs, and extensions, `lowerCamelCase` for variables, functions, parameters, and constants, `lowercase_with_underscores` for files, directories, and packages, and a leading `_` for library-private names.
- **SQL (PostgreSQL):** `snake_case` for tables, columns, and other identifiers. Don't use quoted or mixed-case identifiers.
- **Any other language:** use that language's official or dominant style guide.
