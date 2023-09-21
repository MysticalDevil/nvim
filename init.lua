-- Basic configure
require("configs.core.basic")
-- Advanced configure
require("configs.core.advanced")
-- Bootstrap necessary plugins
require("configs.core.bootstrap")
-- Key bindings
require("configs.core.keybindings")
-- Auto command
require("configs.core.autocmds")
-- Lazy plugins manage
require("plugins.setup")
-- Color scheme setting
require("configs.colorscheme.setup")

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
