local M = {}

function M.setup()
  require("devil.core.mappings").setup()
  require("devil.tools")
  require("devil.complete")
  require("devil.commands")
  require("devil.core.colorscheme")
end

return M
