local status, null_ls = pcall(require, "null-ls")
if not status then
  vim.notify("null-ls not found", "error")
  return
end

-- Union mason and null-ls
local mason_null_ls = require("mason-null-ls")

mason_null_ls.setup({
  ensure_installed = {
    -- Opt to list sources here, when available in mason.
  },
  automatic_installation = false,
  automatic_setup = true, -- Recommended, but optional
})

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
        "h",
        "cpp",
        "cppm",
        "hpp",
        "cuda",
        "objcpp",
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
    -- Protocol Buffer
    -- go install github.com/bufbuild/buf/cmd/buf@@latest
    formatting.buf,
    -- Scala
    -- builtin coursier
    formatting.scalafmt,
    -- Shell
    -- pip install beautysh
    formatting.beautysh,
    -- Lua
    -- cargo install stylua
    formatting.stylua,
    -- ESLint
    -- npm install @eslint
    formatting.eslint_d.with({
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    }),
    -- ECMAScript HTML CSS
    -- npm install prettier
    formatting.prettier.with({
      filetypes = {
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
    -- composer global require "squizlabs/php_codesniffer=*"
    formatting.phpcsfixer,
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
    -- C/C++
    -- pacman -S cppcheck
    diagnostics.cppcheck,
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
    -- Protocol Bufer
    -- go install github.com/bufbuild/buf/cmd/buf@@latest
    diagnostics.buf,
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
  on_attach = function(client)
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()']])
    -- if client.resolved_capabilities.document_formatting then
    --   vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    -- end
  end,
  require("typescript.extensions.null-ls.code-actions"),
  diagnostic_config = {
    -- see :help vim.diagnostic.config()
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    show_header = false,
    severity_sort = true,
    float = {
      source = "always",
      border = "rounded",
      style = "minimal",
      header = "",
      -- prefix = " ",
      -- max_width = 100,
      -- width = 60,
      -- height = 20,
    },
  },
})
