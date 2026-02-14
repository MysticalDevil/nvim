# Neovim 配置建议清单（新版）

## 高优先级（建议近期完成）

- [x] Add LDoc to custom `utils` modules and standardize code comments to English  
  Completed: `lua/devil/utils/common.lua`, `lua/devil/utils/command.lua`, `lua/devil/utils/lsp_tool.lua`, `lua/devil/utils/ebuild_cmds.lua`, `lua/devil/utils/init.lua`  
  Also updated non-English code comments in `lua/` to English.

- [x] 增加最小化启动保护（缺失插件时优雅降级）  
  现状：`init.lua` 会直接 `require("devil.lsp") / require("devil.complete")`。在依赖未安装场景会直接报错中断。  
  建议：对关键模块入口加 `pcall(require, ...)`，至少保证编辑器可启动并给出可读提示。

- [x] 清理和统一配置中的英文文案/拼写  
  现状：存在多处拼写问题（如 `avaiable`、`Boostrating`、`Formater`），以及中英文注释风格混杂。  
  建议：统一术语和提示文案，降低后续维护成本。

- [x] 为关键行为补充“开关”配置层  
  现状：如 `lazy.checker.enabled = true`、自动 lint、自动 inlay hint 等为硬编码。  
  建议：集中放到 `lua/devil/core/options.lua` 或单独 `settings.lua`，便于按机器/场景切换。

- [ ] 增加健康检查入口文档  
  现状：仓库已有 `lua/devil/health.lua`，但使用路径不直观。  
  建议：在 `README.md` 增加“首次安装后检查步骤”（`checkhealth`、Mason、Treesitter、DAP）和常见故障排查。

## 中优先级（建议逐步优化）

- [ ] 进一步收敛启动时立即加载插件数量  
  现状：部分插件使用 `lazy = false`，会提高冷启动负担。  
  建议：按使用频率改成 `event` / `cmd` / `keys` 触发，并配合 `:Lazy profile` 定期回归。

- [ ] LSP Server 列表按“已验证/实验”分层  
  现状：`lua/devil/lsp/lsp_config.lua` 中 server 较多，未来升级时回归成本高。  
  建议：拆成 `stable` 与 `experimental` 两层，默认仅启用稳定层。

- [ ] 规范键位空间并做冲突基线表  
  现状：配置规模较大，后续继续扩展时容易出现 leader 键冲突。  
  建议：在 `README.md` 或独立文档记录 keyspace（如 `<leader>p*`、`<leader>g*` 的保留用途）。

- [ ] 对外部命令依赖做显式声明  
  现状：配置依赖较多 CLI（`rg`、`fd`、`jq`、`stylua`、`goimports` 等）。  
  建议：文档中按语言分组列出必需/可选命令，减少新环境迁移摩擦。

## 低优先级（可选增强）

- [ ] 增加 CI 基础校验（静态 + 最小启动）  
  建议：在 CI 中跑 `stylua --check`、`luacheck/selene`（可选）和一次 `nvim --headless` 冒烟测试。

- [ ] 为平台分支逻辑补充注释  
  现状：已有 Gentoo/NixOS 分支逻辑。  
  建议：在代码旁加“为何这么做”的一句注释，减少未来自己“读不懂当时意图”的成本。

- [ ] 统一“通知噪声”等级策略  
  现状：很多场景都 `vim.notify`，日常使用可能噪声偏高。  
  建议：非关键提示改 `vim.log.levels.DEBUG/TRACE`（或受开关控制），关键错误保留 `ERROR/WARN`。
