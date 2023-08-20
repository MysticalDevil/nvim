require("utils.global")

-- Basic configure
require("configs.core.basic")
-- Key bindings
require("configs.core.keybindings")
-- Lazy plugins manage
require("configs.core.plugins")
-- Color scheme setting
require("configs.core.colorscheme")
-- Auto command
require("configs.core.autocmds")

-- Language server protocol
require("lsp.setup")
-- Auto complete
require("cmp.setup")
-- Formater
require("format.setup")
-- Linter
require("lint.setup")
-- Debug Adapter Protocol
require("dap.setup")
