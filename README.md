# MysticalDevil Neovim 配置

[English](./README.en.md) | [繁體中文](./README.zh-TW.md)

这是一个基于 Lua 和 `lazy.nvim` 的模块化 Neovim 配置，覆盖日常开发中的 LSP、补全、格式化、Lint、DAP 等能力。

## 环境要求

- Neovim `>= 0.11`
- `git`
- 推荐命令行工具：
  - `rg`（ripgrep）
  - `fd`（可选，部分检索场景更快）

## 快速开始

1. 克隆到 Neovim 配置目录：

```bash
git clone https://github.com/MysticalDevil/nvim ~/.config/nvim
```

2. 启动 Neovim：

```bash
nvim
```

该配置会自动 bootstrap `lazy.nvim`，并在启动时安装缺失插件。

## 健康检查

首次启动后建议执行：

```vim
:checkhealth
:Lazy
:Mason
:ConformInfo
```

排查优先顺序：

- Neovim 版本（`nvim --version`）
- 语言工具所需外部可执行程序
- `:Lazy` 中的插件安装状态

## 平台说明

- **Gentoo**：按设计会保留 `/usr/share/vim/vimfiles` 运行时路径。
- **NixOS**：Mason 使用 `PATH = "skip"`，避免覆盖系统包管理的工具链。

## 目录结构

```text
.
├── init.lua
├── ginit.vim
├── after/
└── lua/devil/
    ├── core/          # options, autocmds, mappings, bootstrap, settings
    ├── plugins/       # lazy 插件清单与单插件配置
    ├── lsp/           # LSP 初始化与各语言 server 配置
    ├── complete/      # nvim-cmp 与补全源配置
    ├── fmt-lint/      # conform + nvim-lint
    ├── dap/           # nvim-dap 与语言调试配置
    ├── commands/      # 自定义命令
    ├── utils/         # 公共工具函数
    └── health/        # 健康检查相关
```

## 键位说明

- `mapleader` 为 `Space`
- 核心按键定义在：
  - `lua/devil/core/mappings.lua`
- LSP 相关按键在 LSP attach 后加载。

## 键位空间基线

当前 leader 键空间约定（用于减少后续冲突）：

- `<leader>f*`：查找/检索（Telescope）
- `<leader>w*`：窗口管理
- `<leader>b*`：Buffer 管理
- `<leader>g*`：Git 相关
- `<leader>l*`：LSP/诊断相关
- `<leader>x*`：诊断列表/问题视图
- `<leader>t*`：开关/工具
- `<leader>p*`：性能分析相关
- `<leader>c*`：代码操作/重命名/配置命令

## 主要组件

- 插件管理：[`folke/lazy.nvim`](https://github.com/folke/lazy.nvim)
- LSP：Neovim 内置 LSP + `nvim-lspconfig` + `mason-lspconfig`
- 补全：`nvim-cmp`
- 格式化：`conform.nvim`
- Lint：`nvim-lint`
- 调试：`nvim-dap`
- 语法树：`nvim-treesitter`（通过 `nvim-treesitter.configs.setup` 配置）
- 检索/界面：Telescope、Neo-tree、Noice、Snacks 等

## 外部命令依赖

基础依赖：

- `git`（插件获取与更新）
- `rg`（检索/picker）
- `fd`（可选，更快文件发现）
- `curl`、`unzip`（部分语言工具安装常用）

格式化/Lint（依据当前配置；按文件类型与工具可用性选择）：

- Formatters：`beautysh`、`clang-format`、`gersemi`、`csharpier`、`dart format`、`fish_indent`、`gofumpt`、`goimports-reviser`、`golines`、`biome-check`、`prettierd`、`prettier`、`jq`、`stylua`、`mago_format`、`ruff format`、`isort`、`black`、`rubocop`、`rustfmt`、`taplo`、`xmlformat`、`yamlfmt`、`zigfmt`、`codespell`
- Linters：`cmakelint`、`golangci-lint`、`jsonlint`、`selene`、`markdownlint`、`mago_lint`、`rubocop`、`shellcheck`、`vint`、`yamllint`

部分插件额外依赖：

- `make`（例如 telescope fzf native）
- Go 工具链（Go 生态插件相关流程）

## 常见问题

### 启动提示缺少模块

`init.lua` 已做安全加载处理。部分插件缺失时 Neovim 仍可启动，并输出提示信息。

### 语言工具不生效

优先检查：

- `:Mason` 中是否安装
- 外部命令是否存在（例如 `:echo exepath('tool')`）
- `lua/devil/fmt-lint/` 中对应文件类型配置

## 贡献

欢迎提交 issue 和 PR。
