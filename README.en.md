# MysticalDevil Neovim Config

[中文](./README.md) | [繁體中文](./README.zh-TW.md)

A modular Neovim configuration built for daily development,
troubleshooting, and long-term maintenance. It uses Lua and
`lazy.nvim`, with a workflow centered on LSP, completion, formatting,
linting, DAP, testing, and Treesitter.

## Documentation Index

- Plugin architecture and categories: [`docs/plugins.md`](./docs/plugins.md)
- External tools and formatter/linter routing: [`docs/tools.md`](./docs/tools.md)

## Quick Start

### Requirements

- Neovim `>= 0.12`
- `git`
- Strongly recommended: `rg`, `fd`, `curl`, `unzip`
- Install language-specific LSP, formatter, linter, and DAP tools as needed

### Install

```bash
git clone https://github.com/MysticalDevil/nvim ~/.config/nvim
nvim
```

On first launch, the config bootstraps `lazy.nvim` and installs missing
plugins automatically.

### First Checks

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
3. language tool state in `:Mason`
4. external executables available in `PATH`

## Validation Commands

There is no dedicated unit-test suite in this repo. Day-to-day
verification is mostly static checks plus a smoke test:

```bash
nvim --headless "+lua assert(pcall(require, 'devil.core'))" "+qa"
stylua --check .
rg --files -g '*.lua' | xargs -r -n 1 luac5.1 -p
lua5.1 lua/devil/health/check_keymap_conflicts.lua
pre-commit run --all-files
```

For any change, run at least the smallest relevant subset.

## Runtime Model

### Startup Flow

[`init.lua`](./init.lua) is the entrypoint. Startup runs in this order:

1. enforce the Neovim version floor
2. safely load `devil.core`
3. register early mappings
4. bootstrap `lazy.nvim`
5. load plugin specs
6. let `devil.app` attach mappings, tools, completion, commands, and colors

The config uses `safe_require()` heavily, so non-critical module errors
should usually surface as notifications instead of preventing startup.

### Platform Differences

- Gentoo: keeps `/usr/share/vim/vimfiles` in `runtimepath` for
  compatibility with system-wide Vim scripts.
- Non-Gentoo: removes that path to avoid mixing Vim and Neovim plugins.
- NixOS: `mason.nvim` uses `PATH = "skip"` so it does not override
  system-managed toolchains.

## Repository Map

```text
.
├── init.lua
├── ginit.vim
├── after/
├── docs/
└── lua/devil/
    ├── app/
    ├── commands/
    ├── complete/
    ├── core/
    ├── health/
    ├── plugins/
    ├── shared/
    └── tools/
```

### Change Entry Points

- Core options, autocmds, filetypes, colors: `lua/devil/core/`
- Plugin specs: `lua/devil/plugins/`, `lua/devil/plugins/lang/`
- Larger plugin configs: `lua/devil/plugins/configs/`
- LSP, formatting, linting, DAP: `lua/devil/tools/`
- Completion and snippets: `lua/devil/complete/`
- Custom commands: `lua/devil/commands/`
- Health checks: `lua/devil/health/`
- Filetype overrides: `after/ftplugin/`

## Feature Summary

- Plugin management: `lazy.nvim`
- Structural editing: `nvim-treesitter`, `nvim-ufo`, `rainbow-delimiters.nvim`
- Search and navigation: `telescope.nvim`, `smart-open.nvim`, `flash.nvim`, `trouble.nvim`
- UI layer: `bufferline.nvim`, `lualine.nvim`, `neo-tree.nvim`, `noice.nvim`, `snacks.nvim`
- Code intelligence: `nvim-lspconfig`, `mason.nvim`, `nvim-cmp`, `LuaSnip`
- Code quality: `conform.nvim`, `nvim-lint`
- Debugging and testing: `nvim-dap`, `nvim-dap-ui`, `neotest`, `vim-test`
- Language-specific extras: Lua, Rust, Python, Go, Web, Dart, Java, CMake, xmake, Roslyn

See [`docs/plugins.md`](./docs/plugins.md) for the full plugin overview.

## Usage Conventions

### Leader Conventions

- `mapleader` is `Space`
- Core mappings live in `lua/devil/core/mappings.lua`
- LSP mappings are loaded on attach
- Early `/` mapping enables very-magic search by default

### Leader Namespaces

- `<leader>f*`: find and search
- `<leader>w*`: window management
- `<leader>b*`: buffer management
- `<leader>g*`: git
- `<leader>l*`: LSP and diagnostics
- `<leader>x*`: Trouble and list views
- `<leader>t*`: toggles and tools
- `<leader>p*`: profiling
- `<leader>c*`: code actions and config commands

## Custom Commands

Global commands:

- `:BufOnly`: close every loaded buffer except the current one
- `:CopyRelPath`: copy the current file's relative path to the system clipboard
- `:ToggleDiagnostics`: toggle diagnostics globally
- `:FixIndent`: run `retab` and full-buffer reindent on the current file
- `:InlayHintsToggle` / `:InlayHintsEnable` / `:InlayHintsDisable`: control inlay hints for the current buffer

Filetype-local commands:

- `:PkgManifest`: run `pkgdev manifest` in the current ebuild directory
- `:PkgCheck`: run `pkgcheck scan` in the current ebuild directory

## Operations

- Plugin sync, updates, and state: `:Lazy`
- LSP and external tool install state: `:Mason`
- Formatter routing and format-on-save state: `:ConformInfo`
- Health checks: `:checkhealth`
- Keymap conflict check: `lua5.1 lua/devil/health/check_keymap_conflicts.lua`

For the current formatter/linter matrix, see [`docs/tools.md`](./docs/tools.md).

## Troubleshooting

### Startup Reports Missing Modules

Check these in order:

1. whether `:Lazy` finished installation
2. whether `:checkhealth` reports a core failure
3. whether the failing module belongs to `core`, `plugins`, `tools`, or `complete`
4. whether `init.lua`, `app/`, or `plugins/init.lua` changed recently

### Language Tools Do Not Run

Check these first:

1. install state in `:Mason`
2. `:echo exepath('tool')` for external executable discovery
3. whether the filetype is declared in `lua/devil/tools/format.lua`, `lua/devil/tools/lint.lua`, or `lua/devil/tools/lsp/`
4. explicit errors in `:ConformInfo`, LSP logs, or `:messages`

### Format On Save Does Not Trigger

Common causes:

1. no formatter mapping for the current filetype
2. target formatter not installed
3. a special branch skipped formatting, for example web files without `oxfmt`
4. LSP fallback unavailable or timed out

## Contributing

Issues and pull requests are welcome.

- Use Conventional Commits, for example `fix(mappings): correct toggle behavior`
- If a change affects behavior, dependencies, or maintenance workflow,
  update the corresponding README or `docs/*.md` in the same change
