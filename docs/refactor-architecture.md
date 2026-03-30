# 架构重构建议

## 背景

当前这份配置已经具备较完整的功能覆盖，但目录分层和职责边界正在持续恶化。
问题不在于文件数量，而在于多个维度同时参与组织：

- 一部分按启动阶段分层：`core/`、`plugins/`、`lsp/`、`dap/`
- 一部分按插件管理器实现分层：`plugins/specs/`、`plugins/configs/`
- 一部分按可复用工具分层：`utils/`
- 一部分又按语言或能力横切：`lsp/config/`、`dap/config/`、`fmt-lint/`

结果是新增或修改一个功能时，往往要跨越多个目录，定位成本高，边界也不稳定。

## 现状诊断

### 1. 插件定义与插件配置被强制拆开

现在的典型路径是：

- 插件声明在 `lua/devil/plugins/specs/*.lua`
- 插件选项在 `lua/devil/plugins/configs/*.lua`
- 插件快捷键又来自 `lua/devil/core/mappings.lua`

这会导致一个插件的完整行为被拆散到多个位置。
例如要改 `telescope`、`neo-tree` 或 `gitsigns`，通常要来回切多个文件。

### 2. `core/mappings.lua` 已经承担了过多职责

`lua/devil/core/mappings.lua` 同时承担：

- 全局基础按键
- 插件按键
- LSP 按键
- DAP 按键
- Lazy 侧 `keys` 的来源

再叠加 `utils.get_lazy_keys()` 这种反向依赖，形成了：

- 插件 spec 依赖映射总表
- 映射总表又隐含插件能力边界

这会让按键层和插件层互相缠绕。

### 3. `utils/` 正在演变成兜底层

`lua/devil/utils/init.lua` 聚合导出多个模块，并在冲突时保留第一份定义。

这类写法短期方便，长期的问题是：

- 调用方看不出函数真实来源
- API 边界模糊
- 命名冲突被“掩盖”而不是被消除
- `utils` 会逐渐吸收不属于“通用工具”的业务逻辑

### 4. `settings.lua` 已经开始变成全局配置垃圾桶

`lua/devil/core/settings.lua` 当前同时承载：

- lazy.nvim 行为
- LSP 分组开关
- lint 触发策略
- notify 级别

这说明它不再是单一配置入口，而是在承接多个领域的运行时开关。

### 5. 语言能力被分散到多层

语言相关逻辑现在散落在：

- `plugins/specs/prog.lua`
- `lsp/`
- `dap/`
- `fmt-lint/`
- 部分 `plugins/configs/*.lua`

这会导致“按语言维护”非常困难。
例如 Go、Rust、TypeScript 这类语言支持，并不是一个局部模块，而是分布式实现。

## 重构目标

重构目标不是追求目录看起来整齐，而是让维护动作符合直觉：

- 改一个能力，尽量只进一个模块
- 改一个插件，尽量只看一个文件
- 改一门语言，尽量只在同一片区域内完成
- 公共层只保留真正稳定、低变化的复用能力

一句话总结：

### 从“按技术层拆分”切换到“按领域/能力组织，自包含模块”

## 推荐目标结构

```text
lua/devil/
├── app/
│   ├── init.lua
│   └── bootstrap.lua
├── core/
│   ├── options.lua
│   ├── autocmds.lua
│   ├── filetypes.lua
│   └── colorscheme.lua
├── config/
│   ├── plugins.lua
│   ├── lsp.lua
│   ├── lint.lua
│   └── ui.lua
├── shared/
│   ├── notify.lua
│   ├── command.lua
│   ├── highlight.lua
│   └── icons.lua
├── keymaps/
│   ├── init.lua
│   ├── core.lua
│   ├── lsp.lua
│   ├── dap.lua
│   ├── git.lua
│   └── search.lua
├── plugins/
│   ├── init.lua
│   ├── ui.lua
│   ├── editor.lua
│   ├── search.lua
│   ├── git.lua
│   ├── coding.lua
│   └── lang/
│       ├── lua.lua
│       ├── go.lua
│       ├── rust.lua
│       ├── web.lua
│       ├── java.lua
│       └── python.lua
├── lsp/
│   ├── init.lua
│   └── servers/
├── dap/
│   ├── init.lua
│   └── adapters/
├── commands/
│   ├── init.lua
│   ├── inlay_hints.lua
│   └── global.lua
└── health/
```

## 核心设计原则

### 1. 插件 spec 与插件 opts 尽量同文件

优先采用这种写法：

```lua
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = require("devil.keymaps.search").telescope,
    opts = function()
      return {
        -- telescope options
      }
    end,
  },
}
```

除非一个插件配置大到明显影响可读性，否则不要再单独拆去 `plugins/configs/`。

### 2. keymaps 独立成领域模块，不再反向生成 lazy keys

不要继续依赖 `utils.get_lazy_keys()` 从总映射表反推插件 keys。

更合理的方向是：

- `keymaps/core.lua` 维护全局编辑按键
- `keymaps/lsp.lua` 维护 LSP 相关按键
- `keymaps/dap.lua` 维护调试相关按键
- 每个插件需要的 lazy `keys` 直接引用对应 keymaps 模块导出的表

这样依赖方向会更清晰：

- keymaps 为插件提供按键声明
- 插件不再反向依赖一个全局大表

### 3. `shared/` 只保留稳定公共能力

`utils/` 应收缩为 `shared/` 风格的小集合，只留下这类内容：

- 通知封装
- command helper
- highlight helper
- icons 常量

不应继续放：

- keymap 注册入口
- LSP 业务判断
- 插件业务辅助逻辑
- “什么都能放”的聚合导出

### 4. 配置开关按领域拆分

替代单个 `core/settings.lua`，建议拆为：

- `config/plugins.lua`
- `config/lsp.lua`
- `config/lint.lua`
- `config/ui.lua`

这样做的好处是：

- 配置项来源明确
- 每个模块只读自己关心的开关
- 后续新增配置不会自然堆进一个总文件

### 5. 语言能力按语言聚合，而不是按子系统切散

例如 Go 相关能力，应该尽量在相邻位置看到：

- Go 插件 spec
- Go 的 LSP server 定义
- Go 的 DAP adapter/config
- Go 的 formatter/lint 接入

这并不意味着把所有代码都塞进一个文件，而是要求目录结构天然支持“按语言维护”。

## 针对当前仓库的具体建议

### 优先取消 `plugins/configs/` 这层

现有 `plugins/configs/*.lua` 里大多数文件都只是单插件的 opts 返回值。
这类内容和 plugin spec 强绑定，拆开后收益很低，维护成本却很高。

建议逐步把以下内容并回对应 plugin 模块：

- `bufferline.lua`
- `flash.lua`
- `gitsigns.lua`
- `lualine.lua`
- `neo-tree.lua`
- `outline.lua`
- `scrollbar.lua`
- `telescope.lua`
- `which-key.lua`
- `go.lua`
- `flutter-tools.lua`

`others.lua` 应优先拆除，因为它本质是“无法归类配置的临时聚合点”。

### 拆分 `plugins/specs/prog.lua`

`prog.lua` 目前同时承载：

- LSP 基础插件
- formatter/linter
- completion
- DAP
- 多门语言的增强插件

这是一个明显的“过载文件”。

建议拆成：

- `plugins/coding.lua`：cmp、autopairs、conform、lint、通用编码体验
- `plugins/lang/lua.lua`
- `plugins/lang/go.lua`
- `plugins/lang/rust.lua`
- `plugins/lang/web.lua`
- `plugins/lang/java.lua`
- `plugins/lang/python.lua`
- 其他语言按需继续拆分

### 拆分 `core/mappings.lua`

这是当前最应该优先治理的文件。

建议拆法：

- `keymaps/core.lua`：基础编辑、窗口、Buffer、Tab
- `keymaps/lsp.lua`：LSP 与诊断
- `keymaps/dap.lua`：调试
- `keymaps/search.lua`：telescope、spectre、trouble
- `keymaps/git.lua`：gitsigns、lazygit、diff 等
- `keymaps/ui.lua`：bufferline、neo-tree、outline、which-key 等

全局入口只负责注册真正的“全局映射”，而插件 lazy `keys` 则直接按模块导出。

### 收缩 `utils/`

建议逐步替换：

- `devil.utils.notify` -> `devil.shared.notify`
- `devil.utils.highlight` -> `devil.shared.highlight`
- `devil.utils.command` -> `devil.shared.command`

`devil.utils.init` 这种总出口应最终移除。

### 调整启动入口

当前 `init.lua` 顺序加载很多横向模块：

- `devil.core`
- `devil.core.bootstrap`
- `devil.plugins`
- `devil.lsp`
- `devil.complete`
- `devil.fmt-lint`
- `devil.dap`
- `devil.commands`

建议最终收敛为更清晰的启动流程：

1. 环境检查
2. bootstrap
3. core
4. plugins
5. app 级注册项，例如命令、主题、语言能力初始化

如果未来继续拆分，入口层最好只保留少量顶级 orchestrator，
而不是逐个子系统硬编码 require。

## 推荐迁移顺序

### 第一阶段：先拆映射层

先处理 `core/mappings.lua`，因为它是耦合中心。

目标：

- 把映射分文件
- 去掉 `utils.get_lazy_keys()` 的新增依赖
- 为后续插件自包含改造铺路

这是收益最高、风险可控的一步。

### 第二阶段：把插件配置并回插件模块

逐步迁移 `plugins/configs/*.lua` 到对应的插件模块。

目标：

- 一个插件尽量只在一个地方维护
- 消除 `others.lua` 这种临时配置聚合层

### 第三阶段：拆分语言与编码能力

把 `plugins/specs/prog.lua` 按语言和通用编码能力拆开。

目标：

- Go、Rust、Web、Java、Python 等拥有自己的插件入口
- 通用编码能力集中在 `coding.lua`

### 第四阶段：收缩配置与工具层

处理 `settings.lua` 和 `utils/`。

目标：

- 配置按领域拆分
- 公共层收敛到稳定 helper
- 删除模糊聚合出口

## 重构时的边界约束

为避免“越重构越散”，建议明确以下约束：

### 1. 不再新增 `others.lua`、`misc.lua`、`common.lua` 这类兜底文件

这类文件通常意味着边界没有被真正设计，只是被临时回避。

### 2. 插件的 `keys`、`opts`、`config` 尽量相邻

如果一个插件的行为要分散到多个文件，必须有明确理由，而不是习惯性拆层。

### 3. 新增配置项时先判断归属领域

不要默认加进一个全局 `settings.lua`。

### 4. 公共 helper 必须满足“被多个领域稳定复用”

否则就留在所属模块内部，不要过早抽象。

## 最终判断

这份配置最好的重构方向，不是继续强化
`specs/configs/utils/settings` 这种技术层分割，而是改成：

### 按领域组织，自包含模块，插件与配置就近放置，按键与语言能力分别解耦

如果只做一件最重要的事，应该先拆 `core/mappings.lua`。
如果做完整轮重构，优先顺序应是：

1. 拆 `core/mappings.lua`
2. 取消 `plugins/configs/`
3. 拆 `plugins/specs/prog.lua`
4. 收缩 `utils/` 与 `settings.lua`

这条路径最稳，也最符合当前仓库已经形成的复杂度。
