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

local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  debug = false,
  sources = {
    -- Diagnostics  -----------------------------------------------------------
    -- C/C++
    diagnostics.cppcheck,
    -- Clojure
    diagnostics.clj_kondo,
    -- CMake
    -- pip install cmakelang
    diagnostics.cmake_lint,
    -- CSS
    -- npm install stylelint
    diagnostics.stylelint,
    -- ECMAScript
    -- npm install -g eslint_d
    diagnostics.eslint_d.with({
      prefer_local = "node_modules/.bin",
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
    -- Elixir
    diagnostics.credo,
    -- Fish
    diagnostics.fish,
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
    -- Json
    -- npm install jsonlint -g
    diagnostics.jsonlint,
    -- Kotlin
    diagnostics.ktlint,
    -- Lua
    -- luarocks install luacheck
    -- diagnostics.luacheck,
    -- cargo install selene
    diagnostics.selene,
    -- Makefile
    -- go install github.com/mrtazz/checkmake/cmd/checkmake@latest
    diagnostics.checkmake,
    -- Markdown
    -- npm install markdownlint --save-dev
    diagnostics.markdownlint,
    -- Nix
    -- nix profile install github:nerdypepper/statix
    diagnostics.statix,
    -- Perl
    diagnostics.perlimports,
    -- PHP
    -- composer require --dev phpstan/phpstan
    diagnostics.phpstan,
    -- Protocol Buffer
    -- npm install @bufbuild/buf
    diagnostics.buf,
    -- Python
    -- pip install ruff
    diagnostics.ruff,
    -- Ruby
    -- gem install standard
    diagnostics.standardrb,
    -- Shell
    -- cabal install ShellCheck
    diagnostics.shellcheck,
    -- VimScript
    -- pip install vim-vint
    diagnostics.vint,
    -- Yaml
    -- go install github.com/rhysd/actionlint/cmd/actionlint@latest
    diagnostics.actionlint,
    -- pip install yamllint
    diagnostics.yamllint,
    -- ZSH
    diagnostics.zsh,
    --
    -- Code actions -----------------------------------------------------------
    -- ECMAScript
    -- npm install -g eslint_d
    code_actions.eslint_d,
    -- Git
    code_actions.gitsigns,
    -- Go
    -- go install github.com/fatih/gomodifytags@latest
    code_actions.gomodifytags,
    -- go install github.com/josharian/impl@latest
    code_actions.impl,
    -- Nix
    -- nix build git+https://git.peppe.rs/languages/statix
    code_actions.statix,
    -- Shell
    -- cabal install ShellCheck
    code_actions.shellcheck,
  },
  -- #{m}: message
  -- #{s}: source name (defaults to null-ls if not specified)
  -- #{c}: code (if available)
  diagnostics_format = "[#{s}] #{m}",
  diagnostic_config = {
    -- see :help vim.diagnostic.config()
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = {
      severity = { max = vim.diagnostic.severity.WARN },
    },
    show_header = {
      severity = { max = vim.diagnostic.severity.WARN },
    },
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
