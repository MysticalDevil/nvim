if vim.fn.has("nvim-0.10") ~= 1 then
  vim.notify("This config only avaiable on >=nvim-0.10", vim.log.levels.ERROR)
  return
end

if vim.uv.os_uname().release:match("gentoo") then
  vim.opt.rtp:append("/usr/share/vim/vimfiles")
end

-- Basic configure
require("devil.core")

require("devil.core.bootstrap")

-- Lazy plugins manage
require("devil.plugins")

-- Keymappings
require("devil.utils").load_mappings()

-- Language server protocol
require("devil.lsp")
-- Complete engine
require("devil.complete")
-- Formater and Linter
require("devil.fmt-lint")
-- Debug Adapter Protocol
require("devil.dap")

-- Customize commands
require("devil.commands")

require("devil.core.colorscheme")

-- Playground code
-- require("devil.playground.setup")
