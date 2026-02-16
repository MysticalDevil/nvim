# MysticalDevil Neovim Config

[中文](./README.md) | [繁體中文](./README.zh-TW.md)

A modular Neovim configuration built on Lua and `lazy.nvim`, focused on daily development workflows with LSP, completion, formatting, linting, and DAP.

## Requirements

- Neovim `>= 0.11`
- `git`
- Recommended CLI tools:
  - `rg` (ripgrep)
  - `fd` (optional, for faster searching in some pickers)

## Quick Start

1. Clone into your Neovim config directory:

```bash
git clone https://github.com/MysticalDevil/nvim ~/.config/nvim
```

2. Start Neovim:

```bash
nvim
```

This config bootstraps `lazy.nvim` automatically and installs missing plugins on startup.

## Health Check

After first launch, run:

```vim
:checkhealth
:Lazy
:Mason
:ConformInfo
```

If something is missing, check these first:

- Neovim version (`nvim --version`)
- External binaries required by your language tools
- Plugin installation status in `:Lazy`

## Platform Notes

- **Gentoo**: runtime path includes `/usr/share/vim/vimfiles` by design.
- **NixOS**: Mason is configured with `PATH = "skip"` to avoid overriding system-managed toolchains.

## Project Structure

```text
.
├── init.lua
├── ginit.vim
├── after/
└── lua/devil/
    ├── core/          # options, autocmds, mappings, bootstrap, settings
    ├── plugins/       # lazy plugin specs and per-plugin configs
    ├── lsp/           # lsp setup and server-specific configs
    ├── complete/      # nvim-cmp and completion sources
    ├── fmt-lint/      # conform + nvim-lint
    ├── dap/           # nvim-dap and language adapters
    ├── commands/      # custom user commands
    ├── utils/         # shared utility helpers
    └── health/        # health-related checks
```

## Keymap Notes

- `mapleader` is `Space`
- Core mappings live in:
  - `lua/devil/core/mappings.lua`
- LSP-specific mappings are loaded on attach.

## Keyspace Baseline

Current leader-key namespace baseline (to avoid future collisions):

- `<leader>f*`: find/search (Telescope)
- `<leader>w*`: window management
- `<leader>b*`: buffer management
- `<leader>g*`: git operations
- `<leader>l*`: LSP/diagnostics related actions
- `<leader>x*`: diagnostics/trouble list views
- `<leader>t*`: toggles/tools
- `<leader>p*`: profiler/performance helpers
- `<leader>c*`: code actions/rename/config commands

## Main Components

- Plugin manager: [`folke/lazy.nvim`](https://github.com/folke/lazy.nvim)
- LSP: built-in Neovim LSP + `nvim-lspconfig` + `mason-lspconfig`
- Completion: `nvim-cmp`
- Formatting: `conform.nvim`
- Linting: `nvim-lint`
- Debugging: `nvim-dap`
- Syntax tree: `nvim-treesitter` (configured via `nvim-treesitter.configs.setup`)
- Finder/UI: Telescope, Neo-tree, Noice, Snacks, etc.

## External Dependencies

Base:

- `git` (bootstrap/plugins)
- `rg` (search/pickers)
- `fd` (optional, fast file discovery)
- `curl`, `unzip` (often needed by language tooling installers)

Formatting/Linting (based on current config; selected by filetype and tool availability):

- Formatters: `beautysh`, `clang-format`, `gersemi`, `csharpier`, `dart format`, `fish_indent`, `gofumpt`, `goimports-reviser`, `golines`, `biome-check`, `prettierd`, `prettier`, `jq`, `stylua`, `mago_format`, `ruff format`, `isort`, `black`, `rubocop`, `rustfmt`, `taplo`, `xmlformat`, `yamlfmt`, `zigfmt`, `codespell`
- Linters: `cmakelint`, `golangci-lint`, `jsonlint`, `selene`, `markdownlint`, `mago_lint`, `rubocop`, `shellcheck`, `vint`, `yamllint`

Package/build tools used by some plugins:

- `make` (e.g. telescope fzf native extension)
- `go` toolchain (for Go plugin workflows)

## Troubleshooting

### Startup reports missing modules

This config uses safe module loading in `init.lua`. You can still start Neovim even if some plugins are missing.

### Language tool does not run

Check:

- `:Mason` for install status
- External executable availability (`:echo exepath('tool')`)
- Filetype mapping and formatter/linter setup in `lua/devil/fmt-lint/`

## Contributing

Issues and pull requests are welcome.
