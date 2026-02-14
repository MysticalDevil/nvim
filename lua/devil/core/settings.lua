---Runtime behavior toggles for this Neovim config.
---@module devil.core.settings

local M = {}

M.plugins = {
  lazy = {
    checker = {
      enabled = true,
      notify = true,
      frequency = 3600,
      check_pinned = false,
    },
    change_detection = {
      enabled = true,
      notify = true,
    },
  },
}

M.lsp = {
  inlay_hints = {
    auto_enable = true,
  },
  groups = {
    core = true,
    web = true,
    systems = true,
    mobile = false,
    enterprise = false,
    experimental = false,
  },
}

M.lint = {
  auto_run = true,
  events = { "BufEnter", "BufWritePost", "InsertLeave" },
}

M.notify = {
  -- Minimum level emitted through `devil.utils.notify`.
  -- Set to `vim.log.levels.WARN` to reduce UI noise.
  min_level = vim.log.levels.INFO,
}

return M
