local M = {}

function M.setup()
  require("devil.core.mappings").setup()
  require("devil.lsp")
  require("devil.complete")
  require("devil.fmt-lint")
  require("devil.dap")
  require("devil.commands")
  require("devil.core.colorscheme")
end

return M
