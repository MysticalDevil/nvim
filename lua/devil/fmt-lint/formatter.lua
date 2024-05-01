local status, formatter = pcall(require, "formatter")
if not status then
  vim.notify("formatter not found", "error")
  return
end

-- Utilities for creating configurations
-- local util = require("devil.formatter.util")
local filetypes = require("formatter.filetypes")
local config = require("formatter.config")

-- local mason_binary = ("%s/mason/bin/"):format(vim.fn.stdpath("data"))

local settings = {
  lua = {
    filetypes.lua.stylua,
  },

  go = {
    filetypes.go.gofumpt,
    filetypes.go.goimports,
    filetypes.go.golines,
  },

  rust = { filetypes.rust.rustfmt },

  python = {
    filetypes.python.black,
    filetypes.python.isort,
  },

  ruby = { filetypes.ruby.standardrb },

  c = { filetypes.c.clangformat },
  cpp = { filetypes.c.clangformat },
  cmake = { filetypes.cmake.cmakeformat },

  fish = { filetypes.fish.fishindent },
  sh = { filetypes.sh.shfmt },
  zsh = { filetypes.sh.shfmt },

  json = { filetypes.json.fixjson },
  toml = { filetypes.toml.taplo },
  yaml = { filetypes.yaml.yamlfmt },

  java = { filetypes.java.clangformat },
  kotlin = { filetypes.kotlin.ktlint },

  cs = { filetypes.cs.dotnetformat },

  dart = { filetypes.dart.dartformat },

  elixir = { filetypes.elixir.mixformat },

  -- Use the special "*" filetype for defining formatter configurations on
  -- any filetype
  ["*"] = {
    filetypes.any.remove_trailing_whitespace,
    function()
      -- Ignore already configured types.
      local defined_types = config.values.filetype
      if defined_types[vim.bo.filetype] ~= nil then
        return nil
      end
      vim.lsp.buf.format({ async = true })
    end,
  },
}

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
formatter.setup({
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = settings,
})
