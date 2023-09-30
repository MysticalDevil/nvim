-- Basic configure
require("configs.core.setup")
-- Lazy plugins manage
require("plugins.setup")
-- Color scheme setting
require("configs.colorscheme.setup")

-- Language server protocol
require("lsp.setup")
-- Complete engine
require("complete.setup")
-- Formater
require("format.setup")
-- Linter
require("lint.setup")
-- Debug Adapter Protocol
require("dap.setup")

-- Playground code
-- require("playground.setup")
