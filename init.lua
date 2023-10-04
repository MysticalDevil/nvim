if vim.fn.has("nvim-0.10") ~= 1 then
  vim.notify("This config only avaiable on >=nvim-0.10", vim.log.levels.ERROR)
  return
end

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
