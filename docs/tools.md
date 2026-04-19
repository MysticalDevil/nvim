# 外部工具清单

本文档描述当前配置在 `lua/devil/tools/format.lua` 与
`lua/devil/tools/lint.lua` 中实际接入的外部工具，以及它们对应的文件类型。

## 说明

- 格式化由 [conform.nvim](https://github.com/stevearc/conform.nvim) 驱动。
- Lint 由 [nvim-lint](https://github.com/mfussenegger/nvim-lint) 驱动。
- 并非所有工具都会由 `mason.nvim` 统一安装，很多工具仍依赖系统包管理器或语言生态自行提供。
- 有些 filetype 会走条件分支或 fallback，见下方“特殊规则”。

## 格式化工具

| 文件类型 | 工具 |
| --- | --- |
| `bash`, `sh` | `beautysh` |
| `c`, `cpp` | `clang-format` |
| `cmake` | `gersemi` |
| `cs` | `csharpier` |
| `dart` | `dart_format` |
| `fish` | `fish_indent` |
| `go` | `gofumpt`, `goimports-reviser`, `golines` |
| `javascript`, `typescript`, `javascriptreact`, `typescriptreact` | `oxfmt` |
| `json` | `jq` |
| `lua` | `stylua` |
| `markdown` | `rumdl` |
| `php` | `mago_format` |
| `python` | `ruff_format`，fallback 为 `isort` + `black` |
| `ruby` | `rubocop` |
| `rust` | `rustfmt` |
| `toml` | `taplo` |
| `xml` | `xmlformatter` |
| `yaml` | `yamlfmt` |
| `zig` | `zigfmt` |
| 任意文件 `*` | `codespell` |
| 任意文件 `_` | `trim_whitespace` |

## 特殊规则

### Web 文件

- `javascript`、`typescript`、`javascriptreact`、`typescriptreact` 只在 `oxfmt` 可用时格式化。
- 如果当前环境没有 `oxfmt`，这几类文件会直接跳过 formatter，而不是退回到 `prettier`。

### Python

- 优先使用 `ruff_format`。
- 若 `ruff_format` 不可用，则回退到 `isort` 与 `black` 组合。

### YAML

- 默认使用 `yamlfmt`。
- `docker-compose.yml` 仍使用 `yamlfmt`。
- `pubspec.yaml` 明确跳过格式化，避免与 Dart/Flutter 自身工具链冲突。

### 全局后处理

- `codespell` 会作为 `[*]` formatter 参与所有文件的格式化链。
- `trim_whitespace` 会作为 `[_]` formatter 在最终阶段清理行尾空白。

## 保存时格式化策略

- 默认超时：`1000ms`
- `ruby` 归类为慢 formatter，超时：`5000ms`
- `lsp_format = "fallback"`，即优先使用显式 formatter，必要时退回 LSP 格式化

## Lint 工具

| 文件类型 | 工具 |
| --- | --- |
| `cmake` | `cmakelint` |
| `go` | `golangcilint` |
| `javascript`, `javascriptreact`, `typescript`, `typescriptreact` | `oxlint` |
| `json` | `jsonlint` |
| `lua` | `selene` |
| `markdown` | `rumdl` |
| `php` | `mago_lint` |
| `ruby` | `rubocop` |
| `sh` | `shellcheck` |
| `vim` | `vint` |
| `yaml` | `yamllint` |

## Lint 触发时机

以下事件会自动执行 `lint.try_lint()`：

- `BufEnter`
- `BufWritePost`
- `InsertLeave`

## 工具来源参考

常见工具主页：

- `oxfmt` / `oxlint`: <https://oxc.rs/>
- `rumdl`: <https://github.com/rvben/rumdl>
- `mago`: <https://github.com/carthage-software/mago>
- `conform.nvim`: <https://github.com/stevearc/conform.nvim>
- `nvim-lint`: <https://github.com/mfussenegger/nvim-lint>

## 排障建议

当 formatter 或 linter 没有运行时，优先检查：

1. `:echo &filetype` 是否符合预期
2. `:ConformInfo` 中是否识别到 formatter
3. `:echo exepath('tool-name')` 是否能找到对应命令
4. `:messages` 是否有执行错误
5. 当前文件是否命中特殊跳过逻辑，例如 `pubspec.yaml` 或缺少 `oxfmt`
