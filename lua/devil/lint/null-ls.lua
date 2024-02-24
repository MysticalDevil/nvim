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
    -- Clojure
    diagnostics.clj_kondo,
    -- CMake
    -- pip install cmakelang
    diagnostics.cmake_lint,
    -- CSS
    -- npm install stylelint
    diagnostics.stylelint,
    -- Elixir
    diagnostics.credo,
    -- Fish
    diagnostics.fish,
    -- Java
    -- checkstyle.jar
    diagnostics.checkstyle.with({
      extra_args = { "-c", "/google_checks.xml" }, -- or "/sun_checks.xml" or path to self written rules
    }),
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
