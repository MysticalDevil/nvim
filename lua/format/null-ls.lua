local status, null_ls = pcall(require, "null-ls")
if not status then
  vim.notify("null-ls not found", "error")
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion

null_ls.setup({
  debug = false,
  sources = {
    completion.luasnip,
    -- Formatting -------------------------------------------------------------
    -- C/C++
    -- pacman -S clang-format
    formatting.clang_format.with({
      filetypes = {
        "c",
        "cpp",
        "h",
        "hpp",
        "cuda",
        "cppm",
      },
    }),
    -- CMake
    -- pip install cmake-format
    formatting.cmake_format,
    -- CSharp
    -- dotnet tool install csharpier -g
    formatting.csharpier,
    -- Elixir
    -- pacman -S mix
    formatting.mix,
    -- Fish
    -- builtin fish shell
    formatting.fish_indent,
    -- Go
    -- go install mvdan.cc/gofumpt@latest
    formatting.gofumpt,
    formatting.goimports_reviser,
    -- Json
    -- npm install -g fixjson
    formatting.fixjson,
    -- Nginx
    -- npm install -g nginxbeautifier
    formatting.nginx_beautifier,
    -- OCaml
    -- opam install ocamlformat
    formatting.ocamlformat,
    -- PgSQL
    -- builtin postgresql
    formatting.pg_format,
    -- Scala
    -- builtin coursier
    formatting.scalafmt,
    -- Shell
    -- pacman -S shfmt
    formatting.shfmt,
    -- Lua
    -- cargo install stylua
    formatting.stylua,
    -- ECMAScript HTML CSS
    -- npm install prettier
    formatting.prettier.with({
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "yaml",
        "graphql",
        "markdown",
      },
      timeout = 10000,
      prefer_local = "node_modules/.bin",
    }),
    -- PHP
    -- builtin php
    formatting.php,
    -- Python
    -- pip install black isort
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.isort,
    -- Ruby
    -- gem install rubocop
    formatting.rubocop,
    -- Rust
    -- rustup component add rustfmt
    formatting.rustfmt,
    -- Toml
    -- cargo install taplo-cli
    formatting.taplo,
    -- Yaml
    -- go install github.com/google/yamlfmt/cmd/yamlfmt@latest
    formatting.yamlfmt,
    -- Zig
    -- builtin zig
    formatting.zigfmt,
    --
    -- Diagnostics  -----------------------------------------------------------
    -- ECMAScript
    -- npm install -g eslint_d
    diagnostics.eslint_d.with({
      prefer_local = "node_modules/.bin",
    }),
    -- Go
    -- go install github.com/mgechev/revive@latest
    -- diagnostics.revive,
    -- go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.51.1
    diagnostics.golangci_lint,
    -- Java
    -- checkstyle.jar
    diagnostics.checkstyle.with({
      extra_args = { "-c", "/google_checks.xml" }, -- or "/sun_checks.xml" or path to self written rules
    }),
    -- Python
    -- pip install pylint
    diagnostics.pylint.with({
      diagnostics_postprocess = function(diagnostic)
        diagnostic.code = diagnostic.message_id
      end,
    }),
    -- Lua
    -- luarocks install luacheck
    -- diagnostics.luacheck,
    -- PHP
    -- composer require --dev phpstan/phpstan
    diagnostics.phpstan,
    -- Ruby
    -- gem install rubocop
    diagnostics.rubocop,
    -- Shell
    -- cabal install ShellCheck
    diagnostics.shellcheck,
    -- ZSH
    -- builtin zsh
    diagnostics.zsh,
    --
    -- Code actions -----------------------------------------------------------
    -- Git
    code_actions.gitsigns,
    -- ESLint_d
    -- npm install -g eslint_d
    code_actions.eslint_d,
    -- GoModifyTags
    -- go install github.com/fatih/gomodifytags@latest
    code_actions.gomodifytags,
    -- ShellCheck
    code_actions.shellcheck,
  },
  -- #{m}: message
  -- #{s}: source name (defaults to null-ls if not specified)
  -- #{c}: code (if available)
  diagnostics_format = "[#{s}] #{m}",
  on_attach = function(_)
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()']])
    -- if client.resolved_capabilities.document_formatting then
    --   vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    -- end
  end,
  require("typescript.extensions.null-ls.code-actions"),
})
