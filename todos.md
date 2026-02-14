# Neovim 配置检查待办（按必要程度）

## P0（必须优先修复，可能导致功能失效/报错）

- [x] 修复 TSX 格式化映射拼写错误  
  文件：`lua/devil/fmt-lint/conform.lua:47`  
  问题：`typescriptreadt` 拼写错误，导致 `typescriptreact`（TSX）不会走预期格式化器。  
  建议：改为 `typescriptreact = web_fmt`。

- [x] 修复 `persisted.nvim` 的文件类型忽略逻辑  
  文件：`lua/devil/plugins/configs/persisted.lua:1`、`lua/devil/plugins/configs/persisted.lua:25`  
  问题：`ignore_filetype` 定义为数组，却按哈希表方式 `ignore_filetype[vim.bo.filetype]` 查询，条件恒为 `nil`。  
  影响：本应跳过的 filetype 仍可能被自动保存会话。  
  建议：改为集合表（`{ alpha = true, ... }`）或 `vim.tbl_contains`。

- [x] 处理 `ParinferOn` 命令依赖缺失风险  
  文件：`lua/devil/core/autocmds.lua:28`  
  问题：当前配置里未发现 Parinfer 插件声明，但自动命令直接执行 `ParinferOn`。  
  影响：进入匹配文件时可能报 “Not an editor command: ParinferOn”。  
  建议：二选一  
  1. 补充并启用对应插件；  
  2. 自动命令前先判断命令是否存在（`vim.fn.exists(":ParinferOn") == 2`）。

- [x] 修复 `rustaceanvim` 初始化字段名  
  文件：`lua/devil/plugins/list/prog.lua:170`  
  问题：使用了 `init_option`，lazy.nvim 规范字段应为 `init`。  
  影响：`vim.g.rustaceanvim` 可能未按预期在插件加载前设置。  
  建议：`init_option` 更正为 `init`。

## P1（建议尽快修复，存在行为冲突或平台隐患）

- [ ] 解决 `<leader>ps` 键位冲突  
  文件：`lua/devil/plugins/list/basic.lua:362`、`lua/devil/core/mappings.lua:836`  
  问题：`persisted` 与 `snacks` 都绑定了 `<leader>ps`，语义不同。  
  影响：触发行为不确定/后加载覆盖前加载。  
  建议：拆分成不同键位，避免冲突。

- [ ] 修复 NixOS 下 `mason-lspconfig` 的 `ensure_installed` 赋值  
  文件：`lua/devil/lsp/init.lua:57`  
  问题：`ensure_installed = is_nixos() or {}` 在 NixOS 上会变成布尔值 `true`，而该字段应是列表。  
  建议：改为明确列表或空列表（例如 `is_nixos() and {} or { ... }`）。

- [ ] 解决 Gentoo 运行时路径前后矛盾设置  
  文件：`init.lua:7`、`lua/devil/core/options.lua:70`  
  问题：前面在 Gentoo 下追加 `/usr/share/vim/vimfiles`，后面又无条件移除同一路径。  
  影响：逻辑自相矛盾，维护时易误判。  
  建议：统一策略（保留或移除其一），并按平台条件分支处理。

- [ ] 修正 `cmake-tools.nvim` 的配置字段拼写  
  文件：`lua/devil/plugins/list/prog.lua:256`  
  问题：使用了 `opt = {}`，lazy.nvim 常规字段是 `opts`。  
  影响：该配置项当前基本无效。  
  建议：更正为 `opts = {}`（若确实需要配置）。

## P2（可选优化，提升稳定性和可维护性）

- [ ] 为 Telescope 扩展加载增加容错  
  文件：`lua/devil/plugins/configs/telescope.lua:29`  
  问题：`telescope.load_extension(value)` 未做 `pcall`。  
  影响：某扩展缺失/加载失败时可能中断整体配置。  
  建议：改为 `pcall(telescope.load_extension, value)` 并记录失败扩展。

- [ ] 统一 inlay hint 调用参数写法  
  文件：`lua/devil/core/mappings.lua:257`  
  问题：`is_enabled({ 0 })`、`enable(..., { 0 })` 使用了位置数组。  
  影响：不同版本 API 兼容性差，可读性弱。  
  建议：改为键值形式（如 `{ bufnr = 0 }`）。

- [ ] 为 headless/只读场景加会话写入保护  
  文件：`lua/devil/plugins/configs/persisted.lua:16`  
  现象：在受限环境下退出时自动保存会话可能报写入错误。  
  建议：在 `should_autosave` 中增加目录可写/非 headless 的判断。
