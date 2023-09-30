-- Basic configure
require("configs.core.setup")
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

-- Playground code
-- require("playground.setup")
