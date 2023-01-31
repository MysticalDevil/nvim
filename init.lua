require("utils.global")

-- Basic configure
require("configs.core.basic")
-- Key bindings
require("configs.core.keybindings")
-- Packer plugins manage
require("configs.core.plugins")
-- Color scheme setting
require("configs.core.colorscheme")
-- auto command
require("configs.core.autocmds")

-- Language server protocol
require("lsp.setup")
-- Auto complete
require("cmp.setup")
-- Formater
require("format.setup")
-- DAP
require("dap.setup")

-- local vim_scripts = vim.fn.stdpath("config") .. "/vim"
-- -- Neovide
-- vim.cmd.source(vim_scripts .. "/neovide.vim")
require("configs.gui.neovide")
