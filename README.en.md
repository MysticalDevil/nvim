# MysticalDevil Neovim Config

[中文](./README.md) | [繁體中文](./README.zh-TW.md)

A modular Neovim configuration focused on daily development and ongoing
maintenance. It is built on Lua and `lazy.nvim`, and covers LSP,
completion, formatting, linting, DAP, and a modern tree-sitter setup.
This README is written as an operations manual first, not a plugin
catalog.

## Quick Start

### Requirements

- Neovim `>= 0.11`
- `git`
- Strongly recommended: `rg`, `fd`, `curl`, `unzip`

### Install

```bash
git clone https://github.com/MysticalDevil/nvim ~/.config/nvim
nvim
```

On first launch, the config bootstraps `lazy.nvim` automatically and
installs missing plugins.

### First Validation Pass

After Neovim starts, check these first:

```vim
:checkhealth
:Lazy
:Mason
:ConformInfo
```

Use a fixed triage order:

1. `nvim --version`
2. plugin installation state in `:Lazy`
3. language-tool state in `:Mason`
4. external executable availability in `PATH`

## Operations And Dependencies

### Day-To-Day Maintenance Entry Points

- Plugin sync, updates, and status: `:Lazy`
- LSP and external tool status: `:Mason`
- Formatter routing and format status: `:ConformInfo`
- Full health checks: `:checkhealth`

### Platform Differences

- Gentoo:
  `/usr/share/vim/vimfiles` stays in `runtimepath` for compatibility
  with system-wide Vim scripts and plugins.
- NixOS:
  Mason uses `PATH = "skip"` so it does not override system-managed
  toolchains.

### Dependency Layers

- Required:
  `git`
- Strongly recommended:
  `rg`, `fd`, `curl`, `unzip`
- Enabled by language or feature:
  external tools for formatting, linting, and DAP workflows

### External Tools Used By The Current Config

See [`docs/tools.md`](./docs/tools.md) for the full list of tools with categorized tables.

## Runtime Model And Repo Map

### Startup Flow

The entrypoint is [`init.lua`](./init.lua). It is responsible for:

1. enforcing the Neovim version floor
2. safely loading core modules and reporting failures
3. bootstrapping and loading the plugin system
4. attaching tooling, completion, commands, and colors

That design keeps startup resilient: if a non-critical module fails,
Neovim should still start and surface the error.

### Directory Map

```text
.
├── init.lua
├── ginit.vim
├── after/
└── lua/devil/
    ├── app/
    ├── core/
    ├── plugins/
    ├── complete/
    ├── tools/
    ├── commands/
    ├── shared/
    └── health/
```

### If You Need To Change Something

- Base behavior:
  `lua/devil/core/`
- Plugin declarations and domain modules:
  `lua/devil/plugins/*.lua`, `lua/devil/plugins/lang/*.lua`
- Large per-plugin behavior blocks:
  `lua/devil/plugins/configs/`
- Language servers:
  `lua/devil/tools/lsp/`
- Formatters and linters:
  `lua/devil/tools/format.lua`, `lua/devil/tools/lint.lua`
- Debugging features:
  `lua/devil/tools/dap/`
- Custom commands and shared helpers:
  `lua/devil/commands/`, `lua/devil/shared/`

## Usage Conventions

### Leader Conventions

- `mapleader` is `Space`
- Core mappings live in `lua/devil/core/mappings.lua`
- LSP mappings are loaded on attach

### Leader Namespace Baseline

This is not a full keymap reference. It is the namespace contract used
to reduce future collisions:

- `<leader>f*`: find and search
- `<leader>w*`: window management
- `<leader>b*`: buffer management
- `<leader>g*`: git operations
- `<leader>l*`: LSP and diagnostics
- `<leader>x*`: issue list and Trouble views
- `<leader>t*`: toggles and tools
- `<leader>p*`: performance and profiling
- `<leader>c*`: code actions, rename, and config commands

## Troubleshooting

### Startup Reports Missing Modules

Check these in order:

1. whether `:Lazy` finished installation
2. whether `:checkhealth` reports a core failure
3. which layer the failing module belongs to:
   `core`, `plugins`, `tools`, or `complete`

`init.lua` uses safe loading, so a missing plugin should usually report
an error instead of killing startup outright.

### Language Tools Do Not Run

Check these first:

1. install state in `:Mason`
2. `:echo exepath('tool')` for external executable discovery
3. filetype-specific setup in `lua/devil/tools/lsp/`
   or `lua/devil/tools/`
4. explicit errors in `:ConformInfo` or LSP logs

## Contributing

Issues and pull requests are welcome.
If a behavior change affects usage or maintenance, update the
corresponding README section in the same change.
