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
  servers = {
    include_experimental = false,
  },
}

M.lint = {
  auto_run = true,
  events = { "BufEnter", "BufWritePost", "InsertLeave" },
}

return M
