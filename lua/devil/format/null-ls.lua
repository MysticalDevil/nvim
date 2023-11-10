local status, null_ls = pcall(require, "null-ls")
if not status then
  vim.notify("null-ls not found", "error")
  return
end

-- Union mason and null-ls
local mason_null_ls = require("mason-null-ls")

local G_utils = require("devil.utils")

mason_null_ls.setup({
  ensure_installed = {
    -- Opt to list sources here, when available in mason.
  },
  automatic_installation = false,
  automatic_setup = true, -- Recommended, but optional
})

local formatting = null_ls.builtins.formatting

local lspFormatting = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

null_ls.setup({
  debug = false,
  sources = {
    -- Formatting -------------------------------------------------------------
    -- C/C++
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
    -- Clojure
    formatting.joker.with({ filetypes = { "clj", "clojure", "edn" } }),
    -- CMake
    -- pip install cmake-format
    formatting.cmake_format,
    -- CSharp
    -- dotnet tool install csharpier -g
    formatting.csharpier,
    -- Dart
    formatting.dart_format,
    -- Elixir
    formatting.mix,
    -- Fennel
    formatting.fnlfmt,
    -- Fish
    -- builtin fish shell
    formatting.fish_indent,
    -- Go
    -- go install mvdan.cc/gofumpt@latest
    formatting.gofumpt,
    formatting.goimports_reviser,
    -- Java
    formatting.google_java_format,
    -- Json
    -- npm install -g fixjson
    formatting.fixjson,
    -- Kotlin
    formatting.ktlint,
    -- Lua
    -- cargo install stylua
    formatting.stylua,
    -- Nginx
    -- npm install -g nginxbeautifier
    formatting.nginx_beautifier,
    -- OCaml
    -- opam install ocamlformat
    formatting.ocamlformat,
    -- Perl
    formatting.perlimports,
    formatting.perltidy,
    -- PgSQL
    -- builtin postgresql
    formatting.pg_format,
    -- PHP
    -- composer global require "squizlabs/php_codesniffer=*"
    formatting.phpcsfixer,
    -- Protocal Buffer
    -- npm install @bufbuild/buf
    formatting.buf,
    -- Python
    -- pip install black isort
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.isort,
    -- Ruby
    -- gem install rubocop
    -- formatting.rubocop,
    -- gem install standard
    formatting.standardrb,
    -- Rust
    -- rustup component add rustfmt
    formatting.rustfmt,
    -- Scala
    -- builtin coursier
    formatting.scalafmt,
    -- Shell
    -- pip install beautysh
    formatting.beautysh,
    -- Toml
    -- cargo install taplo-cli
    formatting.taplo,
    -- XML
    -- pip install XmlFormatter
    formatting.xmlformat,
    -- Yaml
    -- go install github.com/google/yamlfmt/cmd/yamlfmt@latest
    formatting.yamlfmt,
    -- Zig
    -- builtin zig
    formatting.zigfmt,

    -- ESLint
    -- npm install @eslint
    formatting.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({
          ".eslintrc.js",
          ".eslintrc.cjs",
          ".eslintrc.yaml",
          ".eslintrc.yml",
          ".eslintrc.json",
        })
      end,
    }),
    -- ECMAScript HTML CSS
    -- npm install prettier
    formatting.prettier.with({
      timeout = 10000,
      prefer_local = "node_modules/.bin",
      extra_args = {
        "--no-semi",
      },
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
        "markdown",
        "markdown.mdx",
        "graphql",
        "svelte",
      },
    }),
  },
  -- #{m}: message
  -- #{s}: source name (defaults to null-ls if not specified)
  -- #{c}: code (if available)
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = lspFormatting, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = lspFormatting,
        buffer = bufnr,
        callback = function()
          G_utils.async_formatting(bufnr)
        end,
      })
    end
  end,
})
