if vim.g.vscode then
  require("devil.configs.core.basic")
  require("devil.configs.core.keybindings")
  return
end

if vim.fn.has("nvim-0.10") ~= 1 then
  vim.notify("This config only avaiable on >=nvim-0.10", vim.log.levels.ERROR)
  return
end

if vim.loop.os_uname().release:match("gentoo") then
  vim.opt.rtp:append("/usr/share/vim/vimfiles")
end

-- Basic configure
require("devil.configs.core.setup")

-- require("devil.utils").load_mappings()

-- Lazy plugins manage
require("devil.plugins.setup")
-- Color scheme setting
require("devil.configs.colorscheme.setup")

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

vim.cmd("hi WinBar guibg=None")

-- Playground code
-- require("devil.playground.setup")
