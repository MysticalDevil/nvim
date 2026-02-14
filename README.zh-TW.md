# MysticalDevil Neovim 配置

[English](./README.en.md) | [简体中文](./README.md)

這是一份基於 Lua 與 `lazy.nvim` 的模組化 Neovim 配置，涵蓋日常開發常見需求：LSP、補全、格式化、Lint、DAP。

## 環境需求

- Neovim `>= 0.10`
- `git`
- 建議安裝：
  - `rg`（ripgrep）
  - `fd`（可選，部分檢索場景更快）

## 快速開始

1. 克隆到 Neovim 配置目錄：

```bash
git clone https://github.com/MysticalDevil/nvim ~/.config/nvim
```

2. 啟動 Neovim：

```bash
nvim
```

此配置會自動 bootstrap `lazy.nvim`，並在啟動時安裝缺失插件。

## 健康檢查

首次啟動後建議執行：

```vim
:checkhealth
:Lazy
:Mason
:ConformInfo
```

建議排查順序：

- Neovim 版本（`nvim --version`）
- 語言工具需要的外部可執行檔
- `:Lazy` 的插件安裝狀態

## 平台說明

- **Gentoo**：設計上會保留 `/usr/share/vim/vimfiles` runtime path。
- **NixOS**：Mason 使用 `PATH = "skip"`，避免覆蓋系統套件工具鏈。

## 目錄結構

```text
.
├── init.lua
├── ginit.vim
├── after/
└── lua/devil/
    ├── core/          # options, autocmds, mappings, bootstrap, settings
    ├── plugins/       # lazy 插件清單與單插件配置
    ├── lsp/           # LSP 初始化與各語言 server 配置
    ├── complete/      # nvim-cmp 與補全來源配置
    ├── fmt-lint/      # conform + nvim-lint
    ├── dap/           # nvim-dap 與語言調試配置
    ├── commands/      # 自訂命令
    ├── utils/         # 共用工具函式
    └── health/        # 健康檢查相關
```

## 快捷鍵說明

- `mapleader` 為 `Space`
- 核心快捷鍵定義在：
  - `lua/devil/core/mappings.lua`
- LSP 相關快捷鍵在 LSP attach 後載入。

## 主要組件

- 插件管理：[`folke/lazy.nvim`](https://github.com/folke/lazy.nvim)
- LSP：Neovim 內建 LSP + `nvim-lspconfig` + `mason-lspconfig`
- 補全：`nvim-cmp`
- 格式化：`conform.nvim`
- Lint：`nvim-lint`
- 除錯：`nvim-dap`
- 檢索/介面：Telescope、Neo-tree、Noice、Snacks 等

## 常見問題

### 啟動時提示缺少模組

`init.lua` 已加入安全載入。即使部分插件缺失，Neovim 仍可啟動並提示錯誤資訊。

### 語言工具未生效

請優先檢查：

- `:Mason` 安裝狀態
- 外部命令是否存在（例如 `:echo exepath('tool')`）
- `lua/devil/fmt-lint/` 中對應 filetype 配置

## 貢獻

歡迎提交 issue 與 PR。
