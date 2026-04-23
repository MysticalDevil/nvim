# MysticalDevil Neovim 配置

[English](./README.en.md) | [繁體中文](./README.zh-TW.md)

一份面向日常开发、排障和长期维护的模块化 Neovim 配置。
它基于 Lua 与 `lazy.nvim`，围绕 LSP、补全、格式化、Lint、DAP、测试与
Treesitter 建立了一套偏 IDE 化但仍可拆分维护的工作流。

## 文档索引

- 总体插件分层：[`docs/plugins.md`](./docs/plugins.md)
- 外部工具与 formatter/linter 路由：[`docs/tools.md`](./docs/tools.md)

## 快速开始

### 环境要求

- Neovim `>= 0.12`
- `git`
- 强烈推荐：`rg`、`fd`、`curl`、`unzip`
- 按需安装：各语言的 LSP、formatter、linter、DAP 适配器

### 安装

```bash
git clone https://github.com/MysticalDevil/nvim ~/.config/nvim
nvim
```

首次启动会自动 bootstrap `lazy.nvim` 并安装缺失插件。

### 首次检查

进入 Neovim 后，建议先检查：

```vim
:checkhealth
:Lazy
:Mason
:ConformInfo
```

推荐固定按这个顺序排查：

1. `nvim --version`
2. `:Lazy` 中插件是否安装完成
3. `:Mason` 中语言工具是否可用
4. 相关外部命令是否存在于 `PATH`

## 校验命令

仓库没有单独的单元测试套件，日常维护以静态检查和 smoke test 为主：

```bash
nvim --headless "+lua assert(pcall(require, 'devil.core'))" "+qa"
stylua --check .
rg --files -g '*.lua' | xargs -r -n 1 luac5.1 -p
lua5.1 lua/devil/health/check_keymap_conflicts.lua
pre-commit run --all-files
```

如果改动了启动流程、按键或工具层，至少运行其中最相关的一组命令。

## 运行机制

### 启动流程

入口是 [`init.lua`](./init.lua)。启动时会按这个顺序执行：

1. 检查 Neovim 版本
2. 安全加载 `devil.core`
3. 提前注册基础按键
4. bootstrap `lazy.nvim`
5. 加载插件规格
6. 由 `devil.app` 挂载 mappings、tools、complete、commands、colorscheme

启动阶段大量使用 `safe_require()`，因此非关键模块出错时通常仍能进入编辑器并看到错误提示。

### 平台差异

- Gentoo：保留 `/usr/share/vim/vimfiles` 在 `runtimepath` 中，兼容系统级 Vim 脚本。
- 非 Gentoo：主动移除该路径，避免混用 Vim 与 Neovim 插件。
- NixOS：`mason.nvim` 使用 `PATH = "skip"`，避免覆盖系统工具链。

## 仓库结构

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

- 基础选项、autocmd、文件类型、配色：`lua/devil/core/`
- 插件声明：`lua/devil/plugins/`、`lua/devil/plugins/lang/`
- 大块插件配置：`lua/devil/plugins/configs/`
- LSP、格式化、Lint、DAP：`lua/devil/tools/`
- 补全与 snippets：`lua/devil/complete/`
- 自定义命令：`lua/devil/commands/`
- 健康检查：`lua/devil/health/`
- filetype 覆盖：`after/ftplugin/`

## 功能概览

- 插件管理：`lazy.nvim`
- 代码结构：`nvim-treesitter`、`nvim-ufo`、`rainbow-delimiters.nvim`
- 检索与导航：`telescope.nvim`、`smart-open.nvim`、`flash.nvim`、`trouble.nvim`
- 界面层：`bufferline.nvim`、`lualine.nvim`、`neo-tree.nvim`、`noice.nvim`、`snacks.nvim`
- 代码智能：`nvim-lspconfig`、`mason.nvim`、`nvim-cmp`、`LuaSnip`
- 代码质量：`conform.nvim`、`nvim-lint`
- 调试与测试：`nvim-dap`、`nvim-dap-ui`、`neotest`、`vim-test`
- 语言专项：Lua、Rust、Python、Go、Web、Dart、Java、CMake、xmake、Roslyn

更完整的插件说明见 [`docs/plugins.md`](./docs/plugins.md)。

## 使用约定

### Leader 约定

- `mapleader` 为 `Space`
- 核心按键定义在 `lua/devil/core/mappings.lua`
- LSP 按键在语言服务器 attach 后加载
- 早期搜索键会把 `/` 映射到 very magic 搜索模式

### Leader 命名空间

- `<leader>f*`：查找/检索
- `<leader>w*`：窗口管理
- `<leader>b*`：Buffer 管理
- `<leader>g*`：Git
- `<leader>l*`：LSP / 诊断
- `<leader>x*`：Trouble / 列表视图
- `<leader>t*`：开关 / 工具
- `<leader>p*`：性能分析
- `<leader>c*`：代码动作 / 配置命令

## 自定义命令

全局命令：

- `:BufOnly`：关闭当前 buffer 之外的已加载 buffer
- `:CopyRelPath`：复制当前文件相对路径到系统剪贴板
- `:ToggleDiagnostics`：全局开关诊断显示
- `:FixIndent`：对当前文件执行 `retab` 和全量重新缩进
- `:InlayHintsToggle` / `:InlayHintsEnable` / `:InlayHintsDisable`：控制当前 buffer 的 inlay hints

filetype 局部命令：

- `:PkgManifest`：在当前 ebuild 目录运行 `pkgdev manifest`
- `:PkgCheck`：在当前 ebuild 目录运行 `pkgcheck scan`

## 依赖与运维入口

- 插件同步、更新、状态：`:Lazy`
- LSP 与外部工具安装状态：`:Mason`
- formatter 路由与保存格式化状态：`:ConformInfo`
- 健康检查：`:checkhealth`
- 按键冲突检查：`lua5.1 lua/devil/health/check_keymap_conflicts.lua`

当前 formatter/linter 的完整清单与文件类型映射见 [`docs/tools.md`](./docs/tools.md)。

## 排障

### 启动时报缺少模块

按顺序检查：

1. `:Lazy` 是否已完成安装
2. `:checkhealth` 是否出现核心错误
3. 报错模块属于 `core`、`plugins`、`tools` 还是 `complete`
4. 最近是否改动了 `init.lua`、`app/` 或 `plugins/init.lua`

### 语言工具不生效

优先检查：

1. `:Mason` 中对应工具是否已安装
2. `:echo exepath('tool')` 能否找到外部命令
3. 对应 filetype 是否在 `lua/devil/tools/format.lua`、`lua/devil/tools/lint.lua` 或 `lua/devil/tools/lsp/` 中声明
4. `:ConformInfo`、LSP 日志或 `:messages` 是否有明确错误

### 保存时没有格式化

常见原因：

1. 当前 filetype 没有 formatter 映射
2. 目标 formatter 未安装
3. 当前文件命中特殊分支，例如 Web 文件在未安装 `oxfmt` 时会直接跳过格式化
4. LSP fallback 不可用或超时

## 贡献

欢迎提交 issue 与 PR。

- 提交信息遵循 Conventional Commits，例如 `fix(mappings): correct toggle behavior`
- 如果改动影响行为、依赖或维护方式，请同步更新对应 README 或 `docs/*.md`
