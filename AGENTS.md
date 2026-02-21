# Repository Guidelines

## Project Structure & Module Organization
This repository is a modular Neovim configuration.
- Entry points: `init.lua`, `ginit.vim`.
- Core runtime config: `lua/devil/core/` (`options.lua`, `autocmds.lua`, `mappings.lua`, bootstrap/settings).
- Plugin definitions and plugin-specific setup: `lua/devil/plugins/specs/` and `lua/devil/plugins/configs/`.
- Language tooling: `lua/devil/lsp/`, `lua/devil/complete/`, `lua/devil/fmt-lint/`, `lua/devil/dap/`.
- Custom commands/utilities: `lua/devil/commands/`, `lua/devil/utils/`, `lua/devil/health/`.
- Filetype overrides: `after/ftplugin/`.
- Helper script: `scripts/check_keymap_conflicts.lua`.

## Build, Test, and Development Commands
- `nvim` launches the config and auto-installs missing plugins via `lazy.nvim`.
- `nvim --headless "+lua assert(pcall(require, 'devil.core'))" "+qa"` runs the CI smoke test.
- `stylua --check .` verifies Lua formatting.
- `rg --files -g '*.lua' | xargs -r -n 1 luac5.1 -p` checks Lua syntax.
- `lua5.1 scripts/check_keymap_conflicts.lua` detects unexpected leader/keymap collisions.
- `pre-commit run --all-files` runs local hooks (whitespace, YAML, StyLua).

## Coding Style & Naming Conventions
- Indentation: 2 spaces, UTF-8, LF endings (`.editorconfig`).
- Formatting: StyLua (`stylua.toml`, 120-column width).
- Linting: Selene (`selene.toml`, `std = "neovim"`).
- Module naming: lowercase snake_case files (for example `fmt-lint/conform.lua`).
- Keep plugin specs in `plugins/specs/*.lua` (for example `plugins/specs/core.lua`); keep plugin behavior in `plugins/configs/*.lua`.

## Testing Guidelines
There is no dedicated unit-test suite in this repo; rely on static and smoke checks.
- Run all validation commands above before opening a PR.
- For keymap edits, always run `lua5.1 scripts/check_keymap_conflicts.lua`.
- For startup/runtime changes, run the headless smoke test and `:checkhealth` in Neovim.

## Commit & Pull Request Guidelines
- Use Conventional Commits, consistent with history and commitlint: `type(scope): summary`.
  Example: `fix(mappings): correct toggle behavior`.
- Common types in this repo: `fix`, `refactor`, `chore`, `docs`, `perf`.
- PRs should include: concise purpose, affected modules/paths, validation commands run, and screenshots/GIFs for UI-visible changes (for example `assets/` updates).
