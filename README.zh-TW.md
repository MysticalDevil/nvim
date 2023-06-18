# Neovim 配置文件

這是 MysticalDevil 的 neovim 的配置文件，包含了一些我常用的插件和自定義配置

該配置主要使用[`lazy.nvim`](https://github.com/folke/lazy.nvim)進行插件的管理

該配置中的代碼編輯的等主要針對 go、rust、javascript、typescript、lua 進行配置，其他語言只使用了 nvim-lsp 的基本功能

## 安裝

1.  安裝 neovim：
    我主要使用的 Linux 發行版是 Arch、Gentoo、Debian，其他發行版請自行查看官方文檔。 neovim 版本需要 0.8.0 及以上，因為一些插件在 0.8.0 之前無法正常工作

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

    Debian 建議自行構建，因為 Debian 官方倉庫的 neovim 最新版本為 0.7

2.  克隆該倉庫：

    ```bash
    git clone https://github.com/MysticalDevil/nvim ~/.config/nvim/
    ```

3.  打開 neovim 來安裝插件

    ```bash
    :Lazy install
    ```

## 目錄及文件說明

neovim 如果使用純 lua 配置，那麼配置文件都會集中在`./lua`目錄中，所以該說明無特殊指定的話根目錄指的就是`./lua`目錄

-   `init.lua`使用純 lua 配置 neovim 時的啟動文件
-   `ginit.vim`使用 neovim 前端時加載的額外配置，該配置支持[`neovide`](https://github.com/neovide/neovide)、[`neovim-qt`](https://github.com/equalsraf/neovim-qt)
-   `cmp`補全引擎相關配置，補全引擎使用了[`nvim-cmp`](https://github.com/hrsh7th/nvim-cmp)，代碼片段使用了[`LuaSnip`](https://github.com/L3MON4D3/LuaSnip)、補全圖標採用了[`lspkind`](https://github.com/onsails/lspkind.nvim)
-   `configs/core`核心配置，主要包括了基礎配置、基本按鍵綁定、主題配色、插件列表和 autocmd
-   `configs/gui`前端的字體、動畫等配置
-   `configs/plugin`大多數插件的配置，不包含補全、格式化、DAP、LSP
-   `dap`Debug Adapter Protocol 相關配置，主要使用[`nvim-dap`](https://github.com/mfussenegger/nvim-dap)作為 dap（配置並不好，因為不懂）
-   `format`代碼格式化相關配置，主要使用[`null-ls`](https://github.com/jose-elias-alvarez/null-ls.nvim)
-   `lsp`Language Server Protolcol 相關配置，主要使用[`mason`](https://github.com/williamboman/mason.nvim)進行 LSP、DAP、Linter、Formmater 等包的管理、[`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig)和[`mason-lspconfig`](https://github.com/williamboman/mason-lspconfig.nvim)進行 LSP 的配置
-   `playground`包含一些雜七雜八的代碼
-   `utils`常用的工具庫，如全局函數、更改顏色主題等

## 使用

### 快捷鍵

主要按鍵配置在[`keybindings.lua`](./lua/configs/core/keybindings.lua)和[`which-key.lua`](./lua/configs/plugin/whick-key.lua)文件中

以下是一些常用的快捷鍵

-   `<leader>`鍵為`,`
-   `<leader>w + ...`保存文件及衍生操作（如保存並退出）
-   `<leader>q + ...`退出及衍生操作（如強制退出）
-   `Ctrl-j/k`向下/上滾動 5 行
-   `Ctrl-d/u`向下/上滾動 10 行
-   `gcc/gcb`快速註釋
-   `sv`水平分屏`sh`垂直分屏`sc`關閉分屏`so`關閉其他分屏
-   `Alt-h/j/k/l`窗口之間跳轉
-   `ts`分割標籤`th/l/j/k`前後首尾標籤`tc`關閉標籤
-   `Z`打開代碼塊`zz`關閉代碼塊`Leader-f`格式化代碼
-   其他快捷鍵請參考具體配置

### 插件

以下是一些使用的主要插件

-   [`lazy.nvim`](https://github.com/folke/lazy.nvim)插件管理器，相比[`packer.nvim`](https://github.com/wbthomason/packer.nvim)更簡單易用、性能更好、配置簡單
-   [`onedark.nvim`](https://github.com/navarasu/onedark.nvim)主體顏色，我很喜歡 onedark 配色方案，也可以更改為其他的配色方案
-   [`bufferline.nvim`](https://github.com/akinsho/bufferline.nvim)類似其他編輯器的標籤頁的插件
-   [`Comment.nvim`](`https://github.com/numToStr/Comment.nvim`)行註釋和塊註釋插件
-   [`dashboard-nvim`](https://github.com/glepnir/dashboard-nvim)更美觀的 neovim 的歡迎屏幕，配合[`project.nvim`](https://github.com/ahmedkhalf/project.nvim)來快速打開最近項目或文件
-   [`leap.nvim`](https://github.com/ggandor/leap.nvim)文本快速跳轉插件，快捷鍵為`-`和`_`
-   [`lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim)狀態欄插件
-   [`neo-tree.nvim`](https://github.com/nvim-neo-tree/neo-tree.nvim)文件管理器，之前使用的是[`nvim-tree.lua`](https://github.com/nvim-tree/nvim-tree.lua)
-   [`noice.nvim`](https://github.com/folke/noice.nvim)通知、命令行、彈出菜單等功能的改進插件，有點不穩定
-   [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter)語法樹、語法高亮
-   [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim)查找、篩選、預覽、選擇插件
-   [`gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim)將 git 集成到緩衝區中

## 截圖

主屏幕

![image-20230310210526742](./assets/image-20230310210526742.png)

代碼編輯頁面

![image-20230310210623206](./assets/image-20230310210623206.png)

## 貢獻

歡迎為我的 neovim 配置文件做出貢獻！如果你想要添加新的插件或修改現有配置嗎，請進行 pull request
