# Neovim 插件总览

这份文档总结了当前仓库在 `lua/devil/plugins/specs/` 中声明的插件结构，用来快速回答两个问题：

- 这个配置用了哪些插件
- 每个插件大致负责什么职责

说明：

- 本文以仓库直接声明的插件为主。
- 对只作为依赖出现、但仍然很重要的插件，放在文末“依赖插件生态”里集中说明。
- 细节配置通常位于 `lua/devil/plugins/configs/`、`lua/devil/lsp/`、`lua/devil/fmt-lint/`、`lua/devil/dap/`。

## 总体结构

插件规格按 6 个模块维护：

- `foundation.lua`: 基础设施、主题、图标、通用库
- `core.lua`: 编辑核心体验、界面增强、文件树、搜索替换
- `treesitter.lua`: Treesitter、文本对象、折叠、上下文、任务辅助
- `tools.lua`: 检索、工作区、注释导航、历史与剪贴板增强
- `git.lua`: Git 状态、Diff、Git UI
- `prog.lua`: LSP、补全、格式化、DAP、测试和语言专项插件

如果把依赖项一起算进来，这套配置覆盖的是一个 100+
仓库的插件生态；如果只看仓库顶层直接声明，主体是“基础设施 +
编辑增强 + 检索工具 + 开发工具链”这四层组合。

## 基础设施与外观

来源：`lua/devil/plugins/specs/foundation.lua`

- `folke/lazy.nvim`: 插件管理器，负责延迟加载、依赖解析和启动编排。
- `nvim-lua/plenary.nvim`: Lua 工具库，很多插件的公共依赖。
- `MunifTanjim/nui.nvim`: UI 组件库，给浮窗、选择器、输入框等高级界面提供基础能力。
- `kkharji/sqlite.lua`: SQLite 绑定，供剪贴板历史、智能打开等插件做本地索引或持久化。
- `nvim-mini/mini.icons`: 图标提供器，同时兼容 `nvim-web-devicons` 调用接口。
- `equalsraf/neovim-gui-shim`: GUI 兼容层，方便 `nvim-qt` 等图形客户端运行。
- `folke/tokyonight.nvim`: 当前主题配色基础。

## 核心编辑与界面增强

来源：`lua/devil/plugins/specs/core.lua`

- `akinsho/bufferline.nvim`: Buffer 标签页与缓冲区切换、排序、关闭入口。
- `folke/ts-comments.nvim`: 基于 Treesitter 的注释体验增强。
- `monaqa/dial.nvim`: 扩展增减值能力，适合数字、日期、布尔值、枚举类文本。
- `folke/flash.nvim`: 跳转增强，用标签式移动替代普通单字符查找。
- `MeanderingProgrammer/render-markdown.nvim`: 在编辑区内更直观地渲染 Markdown。
- `lukas-reineke/headlines.nvim`: 为 Markdown 等文档型文件增加更明显的标题分隔和层级视觉。
- `smjonas/inc-rename.nvim`: LSP rename 的交互增强，边输入边预览。
- `nvim-lualine/lualine.nvim`: 状态栏。
- `danymat/neogen`: 为函数、类、模块生成文档注释模板。
- `nvim-neo-tree/neo-tree.nvim`: 文件树和资源树浏览器。
- `folke/noice.nvim`: 重做消息区、命令行和部分弹窗 UI。
- `kevinhwang91/nvim-bqf`: Quickfix 窗口增强。
- `catgoose/nvim-colorizer.lua`: 颜色值高亮，例如十六进制颜色。
- `kevinhwang91/nvim-hlslens`: 搜索命中计数和定位增强。
- `AckslD/nvim-neoclip.lua`: 剪贴板历史管理。
- `bennypowers/nvim-regexplainer`: 光标下正则表达式解释器。
- `petertriho/nvim-scrollbar`: 滚动条与诊断、Git 标记联动展示。
- `nvim-pack/nvim-spectre`: 跨文件搜索替换。
- `kylechui/nvim-surround`: 成对符号的增删改。

这一层决定的是“编辑手感”和“看见什么”。整体风格是：

- 用 `bufferline`、`lualine`、`scrollbar`、`noice` 重建主界面
- 用 `neo-tree`、`spectre`、`flash`、`surround` 提升常用编辑动作效率
- 用 `neogen`、`regexplainer`、`colorizer` 补齐高频辅助动作

## Treesitter 与结构感知

来源：`lua/devil/plugins/specs/treesitter.lua`

- `nvim-treesitter/nvim-treesitter`: 语法树基础设施，负责高亮、缩进、结构分析。
- `nvim-treesitter/nvim-treesitter-textobjects`: 基于语法节点的文本对象、跳转和参数交换。
- `windwp/nvim-ts-autotag`: HTML/JSX/TSX 标签自动闭合与重命名。
- `RRethy/nvim-treesitter-endwise`: 为某些语言自动补全 `end` 等闭合结构。
- `MysticalDevil/ts-inject.nvim`: 给现代前端文件做更好的语言注入识别。
- `nvim-treesitter/nvim-treesitter-context`: 固定显示当前代码上下文。
- `kevinhwang91/nvim-ufo`: 折叠增强。
- `kevinhwang91/promise-async`: `ufo` 依赖。
- `s1n7ax/nvim-window-picker`: 窗口选择器，给窗口级动作提供更可靠的目标选择。
- `stevearc/overseer.nvim`: 任务执行与任务面板。
- `HiPhish/rainbow-delimiters.nvim`: 彩虹括号，帮助识别嵌套层级。

这一层的核心价值是“让编辑器理解代码结构，而不是只理解文本”。

## 检索、工具与工作流插件

来源：`lua/devil/plugins/specs/tools.lua`

- `folke/snacks.nvim`: 一组通用增强组件，这份配置已经把它用于 buffer 删除、重命名联动等日常能力。
- `m4xshen/smartcolumn.nvim`: 智能显示或隐藏 `colorcolumn`。
- `danielfalk/smart-open.nvim`: 借助索引做更智能的文件打开。
- `mrjones2014/smart-splits.nvim`: 窗口移动与调整尺寸增强，并兼顾终端复用器场景。
- `michaelb/sniprun`: 直接在编辑器里运行代码片段或代码块。
- `nvim-telescope/telescope.nvim`: 全局检索和选择框架。
- `johmsalas/text-case.nvim`: 文本大小写风格转换。
- `folke/todo-comments.nvim`: 收集并高亮 TODO/FIXME/NOTE 等注释。
- `Wansmer/treesj`: 结构化 split/join，例如参数列表、对象、数组。
- `folke/trouble.nvim`: 统一展示诊断、引用、quickfix、location list。
- `folke/which-key.nvim`: 按键提示面板。
- `natecraddock/workspaces.nvim`: 工作区目录管理。
- `gbprod/yanky.nvim`: yank/put 行为增强与历史处理。

其中最核心的组合是：

- `telescope.nvim`: 找文件、找内容、找 buffer、找项目
- `trouble.nvim`: 汇总诊断与导航结果
- `which-key.nvim`: 暴露可发现的按键入口
- `workspaces.nvim`: 在多个项目之间快速切换
- `snacks.nvim`: 补足很多“看起来像内建，但其实更顺手”的细节能力

## Git 工作流

来源：`lua/devil/plugins/specs/git.lua`

- `sindrets/diffview.nvim`: Git diff 和文件历史视图。
- `lewis6991/gitsigns.nvim`: 行级 Git 状态、hunk 操作、blame、预览。
- `NeogitOrg/neogit`: 类似 Magit 的 Git TUI。

这三者的分工比较清晰：

- `gitsigns` 负责“当前 buffer 的改动”
- `diffview` 负责“多个文件、多个提交之间的差异浏览”
- `neogit` 负责“提交、暂存、日志、分支等 Git 操作入口”

## 开发工具链与语言支持

来源：`lua/devil/plugins/specs/prog.lua`

### LSP、格式化、补全

- `neovim/nvim-lspconfig`: LSP 基础配置入口。
- `mason-org/mason.nvim`: 外部工具安装器。
- `mason-org/mason-lspconfig.nvim`: `mason` 与 `lspconfig` 的桥接。
- `jay-babu/mason-nvim-dap.nvim`: `mason` 与 DAP 的桥接。
- `stevearc/conform.nvim`: 格式化框架。
- `mfussenegger/nvim-lint`: lint 框架。
- `hrsh7th/nvim-cmp`: 补全引擎。
- `garymjr/nvim-snippets`: snippet 支持。
- `rafamadriz/friendly-snippets`: 通用 snippet 集。
- `windwp/nvim-autopairs`: 成对符号自动补全。
- `onsails/lspkind.nvim`: completion item 图标与类型标签。

### DAP 与调试

- `mfussenegger/nvim-dap`: DAP 客户端。
- `rcarriga/nvim-dap-ui`: 调试 UI 面板。
- `theHamsta/nvim-dap-virtual-text`: 行内调试变量显示。
- `mfussenegger/nvim-dap-python`: Python 调试支持。
- `jbyuki/one-small-step-for-vimkind`: 调试 Neovim Lua 插件本身。

### 语言专项增强

- Lua
  - `folke/lazydev.nvim`: 优化 LuaLS 对 Neovim、lazy.nvim、Snacks、xmake 等环境的识别。
- JSON
  - `b0o/schemastore.nvim`: JSON schema 来源。
- Rust
  - `mrcjkb/rustaceanvim`: Rust 专项体验增强。
  - `saecki/crates.nvim`: `Cargo.toml` 依赖管理辅助。
- Python
  - `linux-cultist/venv-selector.nvim`: 虚拟环境切换。
- Go
  - `ray-x/go.nvim`: Go 开发增强。
  - `ray-x/guihua.lua`: `go.nvim` 辅助 UI 依赖。
- C/C++
  - `Civitasv/cmake-tools.nvim`: CMake 工作流集成。
  - `Mythos-404/xmake.nvim`: xmake 工作流集成。
- Java
  - `nvim-java/nvim-java`: Java 开发体验增强。
- C#
  - `seblyng/roslyn.nvim`: Roslyn 集成。
- Flutter / Dart
  - `nvim-flutter/flutter-tools.nvim`: Flutter 工具集成。
- TypeScript / 前端依赖管理
  - `vuki656/package-info.nvim`: `package.json` 依赖状态和操作增强。

### 结构视图、面包屑与代码动作

- `hedyhli/outline.nvim`: LSP 符号侧栏。
- `Bekaboo/dropbar.nvim`: 面包屑导航。
- `aznhe21/actions-preview.nvim`: 带预览的 LSP code action 选择器。

### 测试

- `vim-test/vim-test`: 通用测试命令后备方案。
- `nvim-neotest/neotest`: 统一测试框架。
- `nvim-neotest/nvim-nio`: `neotest` 基础依赖。
- `nvim-neotest/neotest-python`: Python 适配器。
- `nvim-neotest/neotest-go`: Go 适配器。
- `nvim-neotest/neotest-plenary`: Plenary 测试适配器。
- `marilari88/neotest-vitest`: Vitest 适配器。
- `lawrence-laz/neotest-zig`: Zig 适配器。
- `sidlatau/neotest-dart`: Dart 适配器。

这一层说明这份配置不是“只负责写代码”，而是覆盖了：

- 工具安装
- LSP
- 格式化
- lint
- 补全
- 调试
- 单元测试
- 多语言专项工作流

## Telescope 与补全生态中的依赖插件

这些插件大多不直接暴露为一章配置，但在日常体验里非常关键。

### Telescope 生态

- `debugloop/telescope-undo.nvim`: 撤销历史选择器。
- `nvim-telescope/telescope-ui-select.nvim`: 把 `vim.ui.select` 接入 Telescope。
- `nvim-telescope/telescope-file-browser.nvim`: 文件浏览器扩展。
- `nvim-telescope/telescope-project.nvim`: 项目列表扩展。
- `nvim-telescope/telescope-live-grep-args.nvim`: 带参数的 live grep。
- `desdic/agrolens.nvim`: 更好的 grep 结果预览。
- `nvim-telescope/telescope-fzf-native.nvim`: FZF 原生排序器。

### `nvim-cmp` 生态

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

这些补全源分别把 LSP、buffer、本地路径、命令行、计算器、Git、Treesitter 等信息接进统一补全入口。

## 对这份配置的整体判断

如果只用一句话概括，这是一份明显偏“IDE 化”的 Neovim 配置，特点是：

- 基础编辑体验完整，且偏重可视化和可发现性
- Treesitter、LSP、Telescope、DAP、测试框架配套齐全
- 多语言支持不是点状补丁，而是围绕 Rust、Go、Python、Java、
  Flutter、TypeScript、C/C++ 做了专门补强
- Git、搜索替换、工作区和任务系统都已经接入，不需要再从零搭骨架

如果后续要继续维护这份配置，最值得优先查看的目录是：

- `lua/devil/plugins/specs/`: 看插件声明与分组
- `lua/devil/plugins/configs/`: 看每个插件的行为细节
- `lua/devil/core/mappings.lua`: 看入口按键
- `lua/devil/lsp/`、`lua/devil/dap/`、`lua/devil/fmt-lint/`: 看开发工具链细节
