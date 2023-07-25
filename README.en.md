# Neovim configuration file

这是 MysticalDevil 的 neovim 的配置文件，包含了一些我常用的插件和自定义配置

This configuration mainly uses[`lazy.nvim`](https://github.com/folke/lazy.nvim)Manage plugins

The code editing in this configuration is mainly configured for go, rust, javascript, typescript, lua, and other languages ​​only use the basic functions of nvim-lsp

## Install

1.  Install neovim:
    The Linux distributions I mainly use are Arch, Gentoo, and Debian. Please check the official documentation for other distributions. neovim version needs 0.8.0 and above, because some plugins don't work properly before 0.8.0

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

    Debian recommends building your own, since the latest version of neovim in the official Debian repositories is 0.7

2.  Clone the repository:

    ```bash
    git clone https://github.com/MysticalDevil/nvim ~/.config/nvim/
    ```

3.  Open neovim to install plugins

    ```bash
    :Lazy install
    ```

## Directory and file description

If neovim uses pure lua configuration, the configuration files will be concentrated in`./lua`directory, so if there is no special specification in this description, the root directory refers to`./lua`Table of contents

-   `init.lua`Startup file when configuring neovim with pure lua
-   `ginit.vim`Extra configuration loaded when using the neovim frontend, which supports[`neovide`](https://github.com/neovide/neovide)、[`neovim-qt`](https://github.com/equalsraf/neovim-qt)
-   `cmp`Completion engine related configuration, the completion engine uses[`nvim-cmp`](https://github.com/hrsh7th/nvim-cmp), the code snippet uses[`LuaSnip`](https://github.com/L3MON4D3/LuaSnip), the completion icon uses the[`lspkind`](https://github.com/onsails/lspkind.nvim)
-   `configs/core`Core configuration, mainly including basic configuration, basic key bindings, theme color matching, plugin list and autocmd
-   `configs/gui`Front-end fonts, animations and other configurations
-   `configs/plugin`Configuration for most plugins, excluding completion, formatting, DAP, LSP
-   `dap`Debug Adapter Protocol related configuration, mainly used[`nvim-dap`](https://github.com/mfussenegger/nvim-dap)As a dap (the configuration is not good, because I don't understand)
-   `format`Code formatting related configuration, mainly used[`null-ls`](https://github.com/jose-elias-alvarez/null-ls.nvim)
-   `lsp`Language Server Protocol related configuration, mainly used[`mason`](https://github.com/williamboman/mason.nvim)Manage LSP, DAP, Linter, Formmater and other packages,[`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig)and[`mason-lspconfig`](https://github.com/williamboman/mason-lspconfig.nvim)Perform LSP configuration
-   `playground`Contains some miscellaneous code
-   `utils`Commonly used tool libraries, such as global functions, changing color themes, etc.

## use

### hot key

The main buttons are configured in[`keybindings.lua`](./lua/configs/core/keybindings.lua)and[`which-key.lua`](./lua/configs/plugin/whick-key.lua)in the file

The following are some commonly used shortcut keys

-   `<leader>`key for`,`
-   `<leader>w + ...`Save files and derivative operations (such as save and exit)
-   `<leader>q + ...`Exit and derivative operations (such as forced exit)
-   `Ctrl-j/k`Scroll down/up 5 lines
-   `Ctrl-d/u`Scroll down/up 10 lines
-   `gcc/gcb`quick note
-   `sv`split screen horizontally`sh`vertical split screen`sc`Turn off split screen`so`Turn off other split screens
-   `Alt-h/j/k/l`jump between windows
-   `ts`split label`th/l/j/k`front and back tags`tc`close tab
-   `Z`open code block`zz`close code block`Leader-f`format code
-   For other shortcut keys, please refer to the specific configuration

### plug-in

Here are some of the main plugins used

-   [`lazy.nvim`](https://github.com/folke/lazy.nvim) 插件管理器，相比 [`packer.nvim`](https://github.com/wbthomason/packer.nvim)Easier to use, better performance, and simple configuration
-   [`onedark.nvim`](https://github.com/navarasu/onedark.nvim)The main color, I like the onedark color scheme very much, it can also be changed to other color schemes
-   [`bufferline.nvim`](https://github.com/akinsho/bufferline.nvim)Plugins like tabs for other editors
-   [`Comment.nvim`](`https://github.com/numToStr/Comment.nvim`)Line comments and block comments plugin
-   [`dashboard-nvim`](https://github.com/glepnir/dashboard-nvim)More beautiful neovim welcome screen, with[`project.nvim`](https://github.com/ahmedkhalf/project.nvim)to quickly open recent projects or files
-   [`leap.nvim`](https://github.com/ggandor/leap.nvim)Text quick jump plug-in, the shortcut key is`-`and`_`
-   [`lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim)status bar plugin
-   [`neo-tree.nvim`](https://github.com/nvim-neo-tree/neo-tree.nvim)file manager, previously used the[`nvim-tree.lua`](https://github.com/nvim-tree/nvim-tree.lua)
-   [`noice.nvim`](https://github.com/folke/noice.nvim)Improved plugin for notifications, command line, popup menu, etc., a bit unstable
-   [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter)syntax tree, syntax highlighting
-   [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim)Find, filter, preview, select plugins
-   [`gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim)Integrate git into buffer

## screenshot

Home screen

![image-20230310210526742](./assets/image-20230310210526742.png)

code editing page

![image-20230310210623206](./assets/image-20230310210623206.png)

## contribute

Contributions to my neovim configuration files are welcome! If you want to add new plugins or modify existing configuration, please make a pull request
