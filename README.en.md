# Neovim Config

This is MysticalDevil's neovim config, containing some commonly used plugins and custom configs

This config mainly uses [`lazy.nvim`](https://github.com/folke/lazy.nvim) for plugin management

The code editing configuration here mainly targets go, rust, javascript, typescript, lua, with basic nvim-lsp functionality for other languages

## Installation

1. Install neovim:
   I mainly use Arch, Gentoo, Debian for Linux, please check the official docs for other distros. Neovim version needs to be 0.10.0(nightly) or above, since inlay hints does not work properly before 0.10.0

   ```bash
   # Arch
   sudo pacman -S neovim

   # Gentoo
   sudo emerge -vj app-editors/neovim

   # Debian
   sudo apt install neovim

   # Windows
   scoop install neovim

   # macOS
   brew install neovim
   ```

   For Debian, it's recommended to build from source, since the latest neovim version in Debian official repo is 0.7.2. Build steps:

   ```bash
   # Install necessary library
   sudo apt install git cmake ninja-build gettext unzip curl
   # Clone neovim repository
   git clone https://github.com/neovim/neovim.git
   # Enter neovim source directory
   cd neovim
   # Build neovim
   make CMAKE_BUILD_TYPE=RelWithDebInfo
   # Package as deb
   cd build && cpack -G DEB
   # Install
   sudo dpkg -i nvim-linux64.deb
   ```

2. Clone this repo:

   ```bash
   git clone https://github.com/MysticalDevil/nvim ~/.config/nvim/
   ```

3. Open neovim to install plugins

   ```vim
   Lazy install
   ```

## Directory Structure

If using pure lua config for neovim, all config files will be under `./lua`. So by default the root here means `./lua/devil` to avoid namespace collisions

- `init.lua` Entry file for pure lua config
- `ginit.vim` Additional config loaded when using GUI frontend, supports [`neovide`](https://github.com/neovide/neovide) and [`neovim-qt`](https://github.com/equalsraf/neovim-qt)
- `configs/core` Core configs, includes basic options, keybindings, plugin list, custom commands, autocmds and core plugin setup for initial launch
- `configs/colorscheme` Colorscheme configs, contains various themes, can switch via `setup.lua`
- `configs/gui` GUI related configs like font, animations etc
- `configs/plugin` Configs for most plugins, excluding completion, formatting, DAP, LSP
- `plugins` Default installed plugins, separated into common(`common.lua`), colorschemes(`colorscheme.lua`), git(`git.lua`) and programming(`prog.lua`)
- `complete` Completion plugins config, using [`nvim-cmp`](https://github.com/hrsh7th/nvim-cmp) by default, with [`coq_nvim`](https://github.com/ms-jpq/coq_nvim) as alternative. Snippets provided by [`LuaSnip`](https://github.com/L3MON4D3/LuaSnip), icons by [`lspkind`](https://github.com/onsails/lspkind.nvim)
- `dap` Debug Adapter Protocol configs, powered by [`nvim-dap`](https://github.com/mfussenegger/nvim-dap)
- `format` Formatting configs, using [`none-ls.nvim`](https://github.com/nvimtools/none-ls.nvim), [`conform.nvim`](https://github.com/stevearc/conform.nvim), [`formatter.nvim`](https://github.com/mhartington/formatter.nvim) and [`efm`](https://github.com/mattn/efm-langserver) as alternatives, configurable via `setup.lua`
- `lint` Linting configs, using [`none-ls.nvim`](https://github.com/mfussenegger/none-ls.nvim), [`nvim-lint`](https://github.com/mfussenegger/nvim-lint) and [`efm`](https://github.com/mattn/efm-langserver) as alternatives, configurable via `setup.lua`
- `lsp` Language Server Protocol related configs, using [`mason`](https://github.com/williamboman/mason.nvim) for dependency management, [`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig) and [`mason-lspconfig`](https://github.com/williamboman/mason-lspconfig.nvim) for LSP setup
- `utils` Common utils like global functions, generic configs etc

## Usage

### Keybindings

Main keybindings are in [`keybindings.lua`](./lua/devil/configs/core/keybindings.lua) and [`which-key.lua`](./lua/devil/configs/plugin/whick-key.lua)

Some common bindings:

- `<leader>` is `,`
- `<leader>w + ...` Save file and derivatives (like save and quit)
- `<leader>q + ...` Quit and derivatives (like force quit)
- `Ctrl-j/k` Scroll down/up 5 lines
- `Ctrl-d/u` Scroll down/up 10 lines
- `gcc/gcb` Quick comment
- `sv` Vertical split `sh` Horizontal split `sc` Close current `so` Close others
- `Alt-h/j/k/l` Navigate between windows
- `ts` New tab `th/l/j/k` Tab navigate `tc` Close tab
- `Z` Open fold `zz` Close fold `Leader-f` Format code
- Check keybindings config for more

### Plugins

Some major plugins used:

- [`lazy.nvim`](https://github.com/folke/lazy.nvim) Plugin manager, simpler and faster than [`packer.nvim`](https://github.com/wbthomason/packer.nvim), easy to configure
- [`onedark.nvim`](https://github.com/navarasu/onedark.nvim) Colorscheme, I really like the onedark theme, can be changed to others
- [`bufferline.nvim`](https://github.com/akinsho/bufferline.nvim) Tab pages like other editors
- [`Comment.nvim`](`https://github.com/numToStr/Comment.nvim`) Comment toggling
- [`dashboard-nvim`](https://github.com/glepnir/dashboard-nvim) Fancier start screen, with [`project.nvim`](https://github.com/ahmedkhalf/project.nvim) for quick project/file switch
- [`leap.nvim`](https://github.com/ggandor/leap.nvim) Motion plugin, keys are `-` and `_`
- [`lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim) Statusline
- [`neo-tree.nvim`](https://github.com/nvim-neo-tree/neo-tree.nvim) File explorer, previously [`nvim-tree.lua`](https://github.com/nvim-tree/nvim-tree.lua)
- [`noice.nvim`](https://github.com/folke/noice.nvim) Notify, command line, floating windows etc, a bit unstable
- [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter) Syntax highlight
- [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim) Fuzzy finding, previewing, picking
- [`gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim) Git integration

## Screenshots

Main screen:

![main-screen](./assets/main-screen.png)

Code edit:

![code-edit](./assets/code-edit.png)

## Contributing

Contributions are welcome! Feel free to open PRs to add new plugins or modify existing config.
