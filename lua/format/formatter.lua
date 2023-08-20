local status, formatter = pcall(require, "formatter")
if not status then
  vim.notify("formatter not found", "error")
  return
end

-- Utilities for creating configurations
local util = require("formatter.util")
local filetypes = require("formatter.filetypes")
local config = require("formatter.config")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
formatter.setup({
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    lua = {
      -- "formatter.filetypes.lua" defines default configurations for the
      -- "lua" filetype
      filetypes.lua.stylua,

      -- You can also define your own configuration
      function()
        -- Supports conditional formatting
        if util.get_current_buffer_file_name() == "special.lua" then
          return nil
        end

        -- Full specification of configurations is down below and in Vim help
        -- files
        return {
          exe = "stylua",
          args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
          },
          stdin = true,
        }
      end,
    },

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
  },
})
