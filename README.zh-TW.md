# MysticalDevil Neovim 配置

[English](./README.en.md) | [简体中文](./README.md)

一份面向日常開發、排障與長期維護的模組化 Neovim 配置。
它建立在 Lua 與 `lazy.nvim` 之上，工作流圍繞 LSP、補全、格式化、
Lint、DAP、測試與 Treesitter 展開，整體偏 IDE 化，但仍維持模組化結構。

## 文件索引

- 插件分層與概覽：[`docs/plugins.md`](./docs/plugins.md)
- 外部工具與 formatter/linter 路由：[`docs/tools.md`](./docs/tools.md)

## 快速開始

### 環境需求

- Neovim `>= 0.11`
- `git`
- 強烈建議：`rg`、`fd`、`curl`、`unzip`
- 依需求安裝各語言的 LSP、formatter、linter、DAP 工具

### 安裝

```bash
git clone https://github.com/MysticalDevil/nvim ~/.config/nvim
nvim
```

首次啟動會自動 bootstrap `lazy.nvim` 並安裝缺失插件。

### 首次檢查

進入 Neovim 後，建議先看：

```vim
:checkhealth
:Lazy
:Mason
:ConformInfo
```

建議固定按這個順序排查：

1. `nvim --version`
2. `:Lazy` 的插件安裝狀態
3. `:Mason` 的語言工具狀態
4. 外部可執行檔是否存在於 `PATH`

## 驗證命令

這個倉庫沒有獨立的單元測試套件，日常維護主要依靠靜態檢查與 smoke test：

```bash
nvim --headless "+lua assert(pcall(require, 'devil.core'))" "+qa"
stylua --check .
rg --files -g '*.lua' | xargs -r -n 1 luac5.1 -p
lua5.1 lua/devil/health/check_keymap_conflicts.lua
pre-commit run --all-files
```

任何改動至少應執行最相關的一小組校驗。

## 執行機制

### 啟動流程

入口是 [`init.lua`](./init.lua)。啟動大致依序執行：

1. 檢查 Neovim 最低版本
2. 安全載入 `devil.core`
3. 提前註冊基礎按鍵
4. bootstrap `lazy.nvim`
5. 載入插件規格
6. 由 `devil.app` 掛載 mappings、tools、complete、commands、colorscheme

設定大量使用 `safe_require()`，因此非關鍵模組失敗時，通常仍可進入編輯器並看到錯誤提示。

### 平台差異

- Gentoo：保留 `/usr/share/vim/vimfiles` 於 `runtimepath` 中，以相容系統級 Vim 腳本。
- 非 Gentoo：主動移除該路徑，避免混用 Vim 與 Neovim 插件。
- NixOS：`mason.nvim` 使用 `PATH = "skip"`，避免覆蓋系統管理的工具鏈。

## 倉庫結構

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

### 修改入口速查

- 基礎選項、autocmd、filetype、配色：`lua/devil/core/`
- 插件宣告：`lua/devil/plugins/`、`lua/devil/plugins/lang/`
- 大型插件設定：`lua/devil/plugins/configs/`
- LSP、格式化、Lint、DAP：`lua/devil/tools/`
- 補全與 snippets：`lua/devil/complete/`
- 自訂命令：`lua/devil/commands/`
- 健康檢查：`lua/devil/health/`
- filetype 覆寫：`after/ftplugin/`

## 功能概覽

- 插件管理：`lazy.nvim`
- 結構化編輯：`nvim-treesitter`、`nvim-ufo`、`rainbow-delimiters.nvim`
- 搜尋與導覽：`telescope.nvim`、`smart-open.nvim`、`flash.nvim`、`trouble.nvim`
- 介面層：`bufferline.nvim`、`lualine.nvim`、`neo-tree.nvim`、`noice.nvim`、`snacks.nvim`
- 程式碼智慧：`nvim-lspconfig`、`mason.nvim`、`nvim-cmp`、`LuaSnip`
- 程式碼品質：`conform.nvim`、`nvim-lint`
- 除錯與測試：`nvim-dap`、`nvim-dap-ui`、`neotest`、`vim-test`
- 語言專項：Lua、Rust、Python、Go、Web、Dart、Java、CMake、xmake、Roslyn

更完整的插件說明見 [`docs/plugins.md`](./docs/plugins.md)。

## 使用約定

### Leader 約定

- `mapleader` 為 `Space`
- 核心按鍵定義於 `lua/devil/core/mappings.lua`
- LSP 按鍵於 attach 後載入
- 啟動早期會把 `/` 映射到 very magic 搜尋模式

### Leader 命名空間

- `<leader>f*`：查找/檢索
- `<leader>w*`：視窗管理
- `<leader>b*`：Buffer 管理
- `<leader>g*`：Git
- `<leader>l*`：LSP / 診斷
- `<leader>x*`：Trouble / 列表視圖
- `<leader>t*`：開關 / 工具
- `<leader>p*`：效能分析
- `<leader>c*`：程式碼動作 / 配置命令

## 自訂命令

全域命令：

- `:BufOnly`：關閉目前 buffer 之外的已載入 buffer
- `:CopyRelPath`：複製目前檔案相對路徑到系統剪貼簿
- `:ToggleDiagnostics`：全域開關診斷顯示
- `:FixIndent`：對目前檔案執行 `retab` 與全量重新縮排
- `:InlayHintsToggle` / `:InlayHintsEnable` / `:InlayHintsDisable`：控制目前 buffer 的 inlay hints

filetype 區域命令：

- `:PkgManifest`：在目前 ebuild 目錄執行 `pkgdev manifest`
- `:PkgCheck`：在目前 ebuild 目錄執行 `pkgcheck scan`

## 維運入口

- 插件同步、更新、狀態：`:Lazy`
- LSP 與外部工具安裝狀態：`:Mason`
- formatter 路由與儲存時格式化狀態：`:ConformInfo`
- 健康檢查：`:checkhealth`
- 按鍵衝突檢查：`lua5.1 lua/devil/health/check_keymap_conflicts.lua`

目前 formatter/linter 的完整矩陣見 [`docs/tools.md`](./docs/tools.md)。

## 排障

### 啟動時提示缺少模組

依序檢查：

1. `:Lazy` 是否完成安裝
2. `:checkhealth` 是否回報核心錯誤
3. 失敗模組屬於 `core`、`plugins`、`tools` 還是 `complete`
4. 最近是否改動過 `init.lua`、`app/` 或 `plugins/init.lua`

### 語言工具未生效

優先檢查：

1. `:Mason` 中對應工具是否已安裝
2. `:echo exepath('tool')` 能否找到外部命令
3. 對應 filetype 是否於 `lua/devil/tools/format.lua`、`lua/devil/tools/lint.lua` 或 `lua/devil/tools/lsp/` 中宣告
4. `:ConformInfo`、LSP 日誌或 `:messages` 是否有明確錯誤

### 儲存時沒有格式化

常見原因：

1. 目前 filetype 沒有 formatter 映射
2. 目標 formatter 尚未安裝
3. 命中特殊分支而跳過格式化，例如 Web 檔案未安裝 `oxfmt`
4. LSP fallback 不可用或逾時

## 貢獻

歡迎提交 issue 與 PR。

- 提交訊息遵循 Conventional Commits，例如 `fix(mappings): correct toggle behavior`
- 若改動會影響行為、依賴或維護流程，請同步更新對應 README 或 `docs/*.md`
