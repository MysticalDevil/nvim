# MysticalDevil Neovim 配置

[English](./README.en.md) | [简体中文](./README.md)

一份以日常開發與維護為中心的模組化 Neovim 配置。
它建立在 Lua 與 `lazy.nvim` 之上，涵蓋 LSP、補全、格式化、
Lint、DAP 與現代 tree-sitter 工作流。這份 README 的定位是
維運手冊，不是插件清單。

## 快速開始

### 環境需求

- Neovim `>= 0.11`
- `git`
- 強烈建議安裝：`rg`、`fd`、`curl`、`unzip`

### 安裝

```bash
git clone https://github.com/MysticalDevil/nvim ~/.config/nvim
nvim
```

首次啟動時會自動 bootstrap `lazy.nvim`，並安裝缺失插件。

### 首次驗證

進入 Neovim 後，優先檢查：

```vim
:checkhealth
:Lazy
:Mason
:ConformInfo
```

建議固定用這個排查順序：

1. `nvim --version`
2. `:Lazy` 的插件安裝狀態
3. `:Mason` 的語言工具狀態
4. 外部可執行檔是否存在於 `PATH`

## 維運與依賴

### 日常維護入口

- 插件同步、更新、狀態檢查：`:Lazy`
- LSP 與外部工具狀態：`:Mason`
- formatter 路由與格式化狀態：`:ConformInfo`
- 完整健康檢查：`:checkhealth`

### 平台差異

- Gentoo：
  會保留 `/usr/share/vim/vimfiles` 在 `runtimepath` 中，
  以相容系統級 Vim 腳本與插件。
- NixOS：
  Mason 使用 `PATH = "skip"`，避免覆蓋系統套件管理的工具鏈。

### 依賴分層

- 必需：
  `git`
- 強烈建議：
  `rg`、`fd`、`curl`、`unzip`
- 依語言或功能啟用：
  格式化、Lint、DAP 流程相關外部工具

### 目前配置會使用到的外部工具

完整工具清單及分類表格詳見 [`docs/tools.md`](./docs/tools.md)。

## 執行機制與倉庫地圖

### 啟動流程

入口是 [`init.lua`](./init.lua)。
它主要負責：

1. 檢查 Neovim 最低版本
2. 安全載入核心模組並在失敗時回報
3. bootstrap 並載入插件系統
4. 依序掛載 LSP、補全、格式化/Lint、DAP、命令與配色

這種設計讓啟動流程更有韌性：即使非關鍵模組失敗，
Neovim 通常仍可啟動，並把錯誤直接暴露出來。

### 目錄導航

```text
.
├── init.lua
├── ginit.vim
├── after/
└── lua/devil/
    ├── core/
    ├── plugins/
    ├── lsp/
    ├── complete/
    ├── fmt-lint/
    ├── dap/
    ├── commands/
    ├── utils/
    └── health/
```

### 要改什麼，該去哪裡

- 基礎行為：
  `lua/devil/core/`
- 插件宣告與載入順序：
  `lua/devil/plugins/specs/`
- 單插件行為：
  `lua/devil/plugins/configs/`
- 語言伺服器：
  `lua/devil/lsp/`
- formatter 與 linter：
  `lua/devil/fmt-lint/`
- 除錯能力：
  `lua/devil/dap/`
- 自訂命令與工具函式：
  `lua/devil/commands/`、`lua/devil/utils/`

## 使用約定

### Leader 約定

- `mapleader` 為 `Space`
- 核心快捷鍵定義在 `lua/devil/core/mappings.lua`
- LSP 相關快捷鍵在 attach 後載入

### Leader 命名空間基線

這不是完整快捷鍵手冊，而是用來降低未來衝突的命名約定：

- `<leader>f*`：查找與檢索
- `<leader>w*`：視窗管理
- `<leader>b*`：Buffer 管理
- `<leader>g*`：Git 相關
- `<leader>l*`：LSP 與診斷
- `<leader>x*`：問題清單與 Trouble 視圖
- `<leader>t*`：開關與工具
- `<leader>p*`：效能分析
- `<leader>c*`：程式碼操作、重新命名與配置命令

## 排障

### 啟動時提示缺少模組

依序檢查：

1. `:Lazy` 是否完成安裝
2. `:checkhealth` 是否回報核心錯誤
3. 失敗模組屬於哪一層：
   `core`、`plugins`、`lsp`、`fmt-lint` 或 `dap`

`init.lua` 使用安全載入，因此缺少插件時通常會回報錯誤，
而不是直接讓啟動流程中止。

### 語言工具未生效

優先檢查：

1. `:Mason` 安裝狀態
2. `:echo exepath('tool')` 是否能找到外部命令
3. 對應 filetype 的設定是否位於 `lua/devil/lsp/`
   或 `lua/devil/fmt-lint/`
4. `:ConformInfo` 或 LSP 日誌中是否有明確錯誤

## 貢獻

歡迎提交 issue 與 PR。
若行為改動會影響使用或維護，請在同一筆變更中同步更新
對應的 README 段落。
