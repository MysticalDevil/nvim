# 外部工具清单

本文档列出本配置集成的格式化与静态检查工具。

## 代码格式化

以下工具通过 [conform.nvim](https://github.com/stevearc/conform.nvim) 调用：

- [beautysh](https://github.com/lovesegfault/beautysh) - A Bash beautifier for the masses.
- [clang-format](https://clang.llvm.org/docs/ClangFormat.html) - Tool to format C/C++/… code according to a set of rules and heuristics.
- [gersemi](https://github.com/BlankSpruce/gersemi) - A formatter to make your CMake code the real treasure.
- [csharpier](https://github.com/belav/csharpier) - The opinionated C# code formatter.
- [dart_format](https://dart.dev/tools/dart-format) - Replace the whitespace in your program with formatting that follows Dart guidelines.
- [fish_indent](https://fishshell.com/docs/current/cmds/fish_indent.html) - Indent or otherwise prettify a piece of fish code.
- [gofumpt](https://github.com/mvdan/gofumpt) - Enforce a stricter format than gofmt, while being backwards compatible.
- [goimports-reviser](https://github.com/incu6us/goimports-reviser) - Right imports sorting & code formatting tool (goimports alternative).
- [golines](https://github.com/segmentio/golines) - A golang formatter that fixes long lines.
- [biome-check](https://biomejs.dev/reference/cli/#biome-check) - A toolchain for web projects, aimed to provide functionalities to maintain them.
- [prettierd](https://github.com/fsouza/prettierd) - prettier, as a daemon, for ludicrous formatting speed.
- [prettier](https://github.com/prettier/prettier) - Prettier is an opinionated code formatter.
- [jq](https://github.com/stedolan/jq) - Command-line JSON processor.
- [stylua](https://github.com/JohnnyMorganz/StyLua) - An opinionated code formatter for Lua.
- [mago_format](https://github.com/carthage-software/mago) - Mago is a toolchain for PHP that aims to provide a set of tools to help developers write better code.
- [ruff_format](https://docs.astral.sh/ruff/) - An extremely fast Python linter, written in Rust. Formatter subcommand.
- [isort](https://github.com/PyCQA/isort) - Python utility / library to sort imports alphabetically and automatically separate them into sections and by type.
- [black](https://github.com/psf/black) - The uncompromising Python code formatter.
- [rubocop](https://github.com/rubocop/rubocop) - Ruby static code analyzer and formatter, based on the community Ruby style guide.
- [rustfmt](https://github.com/rust-lang/rustfmt) - A tool for formatting rust code according to style guidelines.
- [taplo](https://github.com/tamasfe/taplo) - A TOML toolkit written in Rust.
- [xmlformatter](https://github.com/pamoller/xmlformatter) - xmlformatter is an Open Source Python package, which provides formatting of XML documents.
- [yamlfmt](https://github.com/google/yamlfmt) - yamlfmt is an extensible command line tool or library to format yaml files.
- [zigfmt](https://github.com/ziglang/zig) - Reformat Zig source into canonical form.
- [codespell](https://github.com/codespell-project/codespell) - Check code for common misspellings.
- [trim_whitespace](https://github.com/stevearc/conform.nvim/blob/master/lua/conform/formatters/trim_whitespace.lua) - Trim trailing whitespace (built-in formatter from conform.nvim).

## 静态检查

以下工具通过 [nvim-lint](https://github.com/mfussenegger/nvim-lint) 调用：

- [cmakelint](https://github.com/cmake-lint/cmake-lint) - Static analysis tool for CMake scripts.
- [golangci-lint](https://github.com/golangci/golangci-lint) - Fast linters runner for Go.
- [jsonlint](https://github.com/zaach/jsonlint) - JSON syntax validator.
- [selene](https://github.com/Kampfkarren/selene) - Lua static analysis tool written in Rust.
- [markdownlint](https://github.com/DavidAnson/markdownlint) - A Node.js style checker and lint tool for Markdown/CommonMark files.
- [mago_lint](https://github.com/carthage-software/mago) - Mago is a toolchain for PHP that aims to provide a set of tools to help developers write better code.
- [rubocop](https://github.com/rubocop/rubocop) - Ruby static code analyzer and formatter, based on the community Ruby style guide.
- [shellcheck](https://github.com/koalaman/shellcheck) - A static analysis tool for shell scripts.
- [vint](https://github.com/Vimjas/vint) - Static analysis tool for Vim script.
- [yamllint](https://github.com/adrienverge/yamllint) - A linter for YAML files.
