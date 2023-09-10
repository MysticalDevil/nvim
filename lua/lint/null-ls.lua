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
    -- pacman -S cppcheck
    diagnostics.cppcheck,
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
    -- pip install ruff
    diagnostics.ruff,
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
    -- diagnostics.rubocop,
    -- gem install standard
    diagnostics.standardrb,
    -- Shell
    -- cabal install ShellCheck
    diagnostics.shellcheck,
    -- VimScript
    -- pip install vim-vint
    diagnostics.vint,
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
    -- Impl
    -- go install github.com/josharian/impl@latest
    code_actions.impl,
    -- ShellCheck
    -- cabal install ShellCheck
    code_actions.shellcheck,
  },
  -- #{m}: message
  -- #{s}: source name (defaults to null-ls if not specified)
  -- #{c}: code (if available)
  diagnostics_format = "[#{s}] #{m}",
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
