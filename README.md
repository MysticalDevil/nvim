# MysticalDevil Neovim 配置

[English](./README.en.md) | [繁體中文](./README.zh-TW.md)

一份以日常开发和维护为中心的模块化 Neovim 配置。
它基于 Lua 与 `lazy.nvim`，覆盖 LSP、补全、格式化、Lint、DAP
以及现代 tree-sitter 工作流，但文档重点放在可安装、可排障、
可维护，而不是堆砌插件列表。

## 快速开始

### 环境要求

- Neovim `>= 0.11`
- `git`
- 推荐安装：`rg`、`fd`、`curl`、`unzip`

### 安装

```bash
git clone https://github.com/MysticalDevil/nvim ~/.config/nvim
nvim
```

首次启动时会自动 bootstrap `lazy.nvim`，并安装缺失插件。

### 首次验证

进入 Neovim 后，优先检查这几项：

```vim
:checkhealth
:Lazy
:Mason
:ConformInfo
```

排查顺序建议固定为：

1. `nvim --version`
2. `:Lazy` 中的插件安装状态
3. `:Mason` 中的语言工具状态
4. 外部可执行程序是否在 `PATH` 中

## 运维与依赖

### 日常维护入口

- 插件同步、更新、状态检查：`:Lazy`
- LSP 与外部工具安装状态：`:Mason`
- 格式化器与 formatter 路由：`:ConformInfo`
- 全局健康检查：`:checkhealth`

### 平台差异

- Gentoo：
  会保留 `/usr/share/vim/vimfiles` 在 `runtimepath` 中，
  兼容系统级 Vim 脚本与插件。
- NixOS：
  Mason 侧使用 `PATH = "skip"`，避免覆盖系统包管理的工具链。

### 依赖分层

- 必需：
  `git`
- 强烈推荐：
  `rg`、`fd`、`curl`、`unzip`
- 按语言或功能启用：
  formatter、linter、DAP 相关外部工具

### 当前配置会使用到的外部工具

完整工具清单及分类表格详见 [`docs/tools.md`](./docs/tools.md)。

## 运行机制与仓库地图

### 启动流程

启动入口是 [`init.lua`](./init.lua)。
它主要负责四件事：

1. 检查 Neovim 版本门槛
2. 安全加载核心模块并在失败时发出通知
3. bootstrap 并加载插件系统
4. 依次挂载工具层、补全、命令与配色

这意味着即使部分模块失效，Neovim 仍尽量可启动并给出错误提示。

### 目录导航

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

### 要改什么，该去哪里

- 改基础行为：
  `lua/devil/core/`
- 改插件声明与领域划分：
  `lua/devil/plugins/*.lua`、`lua/devil/plugins/lang/*.lua`
- 改单插件的大块配置：
  `lua/devil/plugins/configs/`
- 改语言服务器：
  `lua/devil/tools/lsp/`
- 改 formatter / linter：
  `lua/devil/tools/format.lua`、`lua/devil/tools/lint.lua`
- 改调试能力：
  `lua/devil/tools/dap/`
- 改自定义命令或共享 helper：
  `lua/devil/commands/`、`lua/devil/shared/`

## 使用约定

### Leader 约定

- `mapleader` 为 `Space`
- 核心按键定义在 `lua/devil/core/mappings.lua`
- LSP 相关按键在 attach 后加载

### Leader 命名空间基线

这不是完整快捷键手册，而是为了减少未来冲突的命名约定：

- `<leader>f*`：查找/检索
- `<leader>w*`：窗口管理
- `<leader>b*`：Buffer 管理
- `<leader>g*`：Git 相关
- `<leader>l*`：LSP / 诊断
- `<leader>x*`：问题列表 / Trouble 视图
- `<leader>t*`：开关 / 工具
- `<leader>p*`：性能分析
- `<leader>c*`：代码操作 / 重命名 / 配置命令

## 排障

### 启动时提示缺少模块

先看：

1. `:Lazy` 是否安装完整
2. `:checkhealth` 是否有核心错误
3. 报错里提到的模块属于哪一层
   `core`、`plugins`、`tools` 或 `complete`

`init.lua` 已做安全加载，因此部分插件失败时通常不会直接阻止启动。

### 语言工具不生效

优先检查：

1. `:Mason` 中是否已安装对应工具
2. `:echo exepath('tool')` 是否能找到外部命令
3. 对应 filetype 的配置是否存在于 `lua/devil/tools/lsp/`
   或 `lua/devil/tools/`
4. `:ConformInfo` 或相关 LSP 日志是否有明确错误

## 贡献

欢迎提交 issue 与 PR。
如果要改动行为，请尽量同时更新对应 README 段落，
避免文档与实现继续漂移。
