if vim.fn.has("nvim-0.10") ~= 1 then
  vim.notify("This config only avaiable on >=nvim-0.10", vim.log.levels.ERROR)
  return
end

if vim.loop.os_uname().release:match("gentoo") then
  vim.opt.rtp:append("/usr/share/vim/vimfiles")
end

-- Basic configure
require("devil.configs.core.setup")

-- Lazy plugins manage
require("devil.plugins.setup")
-- Color scheme setting
require("devil.configs.colorscheme.setup")

-- Keymappings
require("devil.utils").load_mappings()

-- Language server protocol
require("devil.lsp.setup")
-- Complete engine
require("devil.complete.setup")
-- Formater
require("devil.format.setup")
-- Linter
require("devil.lint.setup")
-- Debug Adapter Protocol
require("devil.dap.setup")

-- Customize commands
require("devil.commands.setup")

require("devil.core.colorscheme")

-- Playground code
-- require("devil.playground.setup")
