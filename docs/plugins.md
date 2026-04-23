# Neovim 插件总览

本文档基于 `lua/devil/plugins/` 与 `lua/devil/plugins/lang/` 的当前实现，概括这份配置的插件分层、职责边界和关键依赖关系。

## 加载结构

插件按领域拆分到这些模块：

- `foundation.lua`：插件管理、主题、图标、基础依赖
- `editor.lua`：编辑增强、注释、文档注释、剪贴板与文本操作
- `ui.lua`：Buffer/UI/文件树/状态栏/通知/面包屑/滚动条
- `search.lua`：Telescope、Trouble、workspace、搜索替换与导航增强
- `git.lua`：Git 状态、diff、Git UI
- `syntax.lua`：Treesitter、折叠、任务、结构感知
- `coding.lua`：LSP、补全、格式化、Lint、DAP
- `testing.lua`：测试框架与适配器
- `lang/*.lua`：语言专项插件

入口在 `lua/devil/plugins/init.lua`，它会收集所有模块的插件规格并交给 `lazy.nvim`。

## 基础设施

来源：`lua/devil/plugins/foundation.lua`

- `folke/lazy.nvim`：插件管理器与加载编排中心
- `nvim-lua/plenary.nvim`：Lua 工具库，多个插件的公共依赖
- `MunifTanjim/nui.nvim`：通用 UI 组件库
- `kkharji/sqlite.lua`：为索引、历史记录等插件提供 SQLite 能力
- `nvim-mini/mini.icons`：图标提供器，并兼容 `nvim-web-devicons`
- `equalsraf/neovim-gui-shim`：图形客户端兼容层
- `folke/tokyonight.nvim`：当前默认主题

## 编辑增强

来源：`lua/devil/plugins/editor.lua`

- `folke/ts-comments.nvim`：基于 Treesitter 的注释体验
- `monaqa/dial.nvim`：数字、日期、枚举文本增减
- `folke/flash.nvim`：快速跳转与 Treesitter 结构跳转
- `MeanderingProgrammer/render-markdown.nvim`：Markdown 即时渲染
- `smjonas/inc-rename.nvim`：LSP rename 的增量交互界面
- `danymat/neogen`：生成文档注释模板
- `kevinhwang91/nvim-bqf`：Quickfix 增强
- `kylechui/nvim-surround`：包围符增删改
- `gbprod/yanky.nvim`：增强 yank/paste 工作流，并接入 yank history

这一层主要改善“编辑动作本身”的效率与反馈。

## 界面层

来源：`lua/devil/plugins/ui.lua`

- `akinsho/bufferline.nvim`：Buffer 标签、切换、关闭与排序
- `folke/snacks.nvim`：dashboard、terminal、notifier、zen、rename、profiler 等综合能力
- `m4xshen/smartcolumn.nvim`：按文件类型智能显示 `colorcolumn`
- `nvim-lualine/lualine.nvim`：状态栏
- `nvim-neo-tree/neo-tree.nvim`：文件树与资源浏览器
- `folke/noice.nvim`：消息区、命令行与弹窗 UI 重构
- `catgoose/nvim-colorizer.lua`：颜色值高亮
- `hedyhli/outline.nvim`：符号侧栏
- `Bekaboo/dropbar.nvim`：面包屑导航
- `s1n7ax/nvim-window-picker`：窗口选择器
- `petertriho/nvim-scrollbar`：滚动条，并与 Git/搜索标记联动

其中 `snacks.nvim` 是这份配置里承担“胶水层”角色最多的 UI 插件之一：

- buffer 删除
- 文件重命名联动
- 通知历史
- zen / zoom
- startup profiler
- 内建 terminal

## 搜索、导航与工作流

来源：`lua/devil/plugins/search.lua`

- `danielfalk/smart-open.nvim`：基于索引的智能打开文件
- `mrjones2014/smart-splits.nvim`：窗口移动、缩放、buffer 交换，并兼容多路复用器场景
- `michaelb/sniprun`：直接运行选中代码或代码块
- `nvim-telescope/telescope.nvim`：统一选择器与检索入口
- `johmsalas/text-case.nvim`：文本大小写转换
- `folke/todo-comments.nvim`：TODO/FIX/WARN/NOTE 等注释高亮
- `folke/trouble.nvim`：诊断、引用、loclist、qflist 统一视图
- `folke/which-key.nvim`：按键提示与命名空间可发现性
- `natecraddock/workspaces.nvim`：工作区目录管理
- `nvim-pack/nvim-spectre`：跨文件搜索替换
- `kevinhwang91/nvim-hlslens`：搜索结果反馈增强

### Telescope 生态

以下扩展被显式接入：

- `debugloop/telescope-undo.nvim`
- `nvim-telescope/telescope-ui-select.nvim`
- `nvim-telescope/telescope-file-browser.nvim`
- `nvim-telescope/telescope-project.nvim`
- `nvim-telescope/telescope-live-grep-args.nvim`
- `desdic/agrolens.nvim`
- `nvim-telescope/telescope-fzf-native.nvim`
- `smart-open.nvim`
- `workspaces.nvim`

这意味着 Telescope 不只是“找文件”，也是本配置很多工作流的统一交互界面。

## Git 工作流

来源：`lua/devil/plugins/git.lua`

- `sindrets/diffview.nvim`：仓库 diff 与历史浏览
- `lewis6991/gitsigns.nvim`：行级 Git 状态、hunk 导航、预览与 blame
- `NeogitOrg/neogit`：Git TUI 入口

职责分工：

- `gitsigns.nvim` 负责当前 buffer 的细粒度改动
- `diffview.nvim` 负责跨文件或历史差异浏览
- `neogit` 负责提交、暂存、日志与分支操作

## Treesitter 与结构感知

来源：`lua/devil/plugins/syntax.lua`

- `nvim-treesitter/nvim-treesitter`：高亮、缩进、结构分析基础设施
- `nvim-treesitter/nvim-treesitter-textobjects`：语法节点文本对象与跳转
- `windwp/nvim-ts-autotag`：标签自动闭合与重命名
- `RRethy/nvim-treesitter-endwise`：自动补全 `end` 等闭合结构
- `MysticalDevil/ts-inject.nvim`：前端与脚本语言注入增强
- `nvim-treesitter/nvim-treesitter-context`：固定显示当前上下文
- `kevinhwang91/nvim-ufo`：折叠增强
- `kevinhwang91/promise-async`：`ufo` 依赖
- `stevearc/overseer.nvim`：任务运行与任务面板
- `HiPhish/rainbow-delimiters.nvim`：彩虹括号

这一层解决的是“让编辑器理解代码结构，而不是只理解文本”。

## 代码智能与工具链

来源：`lua/devil/plugins/coding.lua`

### LSP、格式化、Lint

- `neovim/nvim-lspconfig`：LSP 基础接入
- `mason-org/mason.nvim`：外部工具安装管理
- `mason-org/mason-lspconfig.nvim`：Mason 与 LSP 桥接
- `jay-babu/mason-nvim-dap.nvim`：Mason 与 DAP 桥接
- `stevearc/conform.nvim`：格式化框架
- `mfussenegger/nvim-lint`：Lint 框架

### 补全

- `hrsh7th/nvim-cmp`：补全引擎
- `L3MON4D3/LuaSnip`：snippet 引擎
- `saadparwaiz1/cmp_luasnip`：LuaSnip 补全源
- `rafamadriz/friendly-snippets`：通用 snippet 集合
- `windwp/nvim-autopairs`：补全确认后的配对符处理
- `onsails/lspkind.nvim`：补全项图标与类型标签

### `nvim-cmp` 补全源

- `hrsh7th/cmp-nvim-lsp`
- `hrsh7th/cmp-buffer`
- `hrsh7th/cmp-calc`
- `hrsh7th/cmp-cmdline`
- `hrsh7th/cmp-nvim-lsp-signature-help`
- `hrsh7th/cmp-nvim-lsp-document-symbol`
- `hrsh7th/cmp-nvim-lua`
- `hrsh7th/cmp-path`
- `petertriho/cmp-git`
- `ray-x/cmp-treesitter`

### DAP 与代码动作

- `mfussenegger/nvim-dap`
- `rcarriga/nvim-dap-ui`
- `theHamsta/nvim-dap-virtual-text`
- `aznhe21/actions-preview.nvim`

## 测试层

来源：`lua/devil/plugins/testing.lua`

- `nvim-neotest/neotest`：统一测试框架
- `nvim-neotest/nvim-nio`：`neotest` 基础依赖
- `nvim-neotest/neotest-python`
- `nvim-neotest/neotest-go`
- `nvim-neotest/neotest-plenary`
- `marilari88/neotest-vitest`
- `lawrence-laz/neotest-zig`
- `sidlatau/neotest-dart`

这表示配置已经把“运行测试”视为一等公民，而不是编辑器外部操作。

## 语言专项插件

来源：`lua/devil/plugins/lang/*.lua`

- Lua
  - `folke/lazydev.nvim`：补强 LuaLS 对 Neovim 与插件生态的识别
- Python
  - `linux-cultist/venv-selector.nvim`：虚拟环境切换
  - `mfussenegger/nvim-dap-python`：Python 调试支持
- Go
  - `ray-x/go.nvim`
  - `ray-x/guihua.lua`
- Rust
  - `mrcjkb/rustaceanvim`
  - `saecki/crates.nvim`
- Web / JSON
  - `b0o/schemastore.nvim`
  - `vuki656/package-info.nvim`
- Dart / Flutter
  - `nvim-flutter/flutter-tools.nvim`
- Misc
  - `nvim-java/nvim-java`
  - `seblyng/roslyn.nvim`
  - `Civitasv/cmake-tools.nvim`
  - `Mythos-404/xmake.nvim`

## 这份配置的整体特点

如果只用几句话概括：

- 它不是极简配置，而是一套偏 IDE 化的多语言开发环境
- 插件声明按职责拆分，维护时不必在单一大文件中查找所有逻辑
- Telescope、Trouble、Snacks、Treesitter、LSP 构成了最核心的交互骨架
- Go、Rust、Python、Web、Dart、Java、C/C++ 等语言都有专项补强，而不是只停留在通用 LSP 层

维护时最值得优先阅读的目录：

- `lua/devil/plugins/`
- `lua/devil/plugins/configs/`
- `lua/devil/tools/`
- `lua/devil/core/mappings.lua`
