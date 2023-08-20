local status, formatter = pcall(require, "formatter")
if not status then
  vim.notify("formatter not found", "error")
  return
end

-- Utilities for creating configurations
local util = require("formatter.util")
local filetypes = require("formatter.filetypes")
local config = require("formatter.config")

local mason_binary = function(name)
  return vim.fn.stdpath("data") .. "/mason/bin/" .. name
end

local prettier_defaults = function()
  return {
    exe = mason_binary("prettier"),
    args = {
      "--single-quote",
      "--no-semi",
      util.escape_path(util.get_current_buffer_file_path()),
    },
    stdin = true,
    try_node_modules = true,
  }
end

local shell_defaults = function()
  return {
    exe = mason_binary("beautysh"),
    args = {
      util.escape_path(util.get_current_buffer_file_path()),
    },
    stdin = true,
  }
end

local settings = {
  -- Formatter configurations for filetype "lua" go here
  -- and will be executed in order
  lua = {
    -- "formatter.filetypes.lua" defines default configurations for the
    -- "lua" filetype
    filetypes.lua.stylua,
  },

  go = {
    filetypes.go.gofumpt,
    filetypes.go.goimports,
  },

  rust = { filetypes.rust.rustfmt },

  python = {
    filetypes.python.black,
    filetypes.python.isort,
    filetypes.python.docformatter,
  },

  ruby = { filetypes.ruby.standardrb },

  c = { filetypes.c.clangformat },
  cpp = { filetypes.c.clangformat },
  cmake = { filetypes.cmake.cmakeformat },

  css = { filetypes.css.prettier },
  html = { filetypes.html.prettier },
  javascript = prettier_defaults,
  typescript = prettier_defaults,
  javascriptreact = prettier_defaults,
  typescriptreact = prettier_defaults,
  vue = prettier_defaults,

  fish = { filetypes.fish.fishindent },
  sh = shell_defaults,
  zsh = shell_defaults,

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
