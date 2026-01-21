local M = {}

function M.check()
  require("devil.health.ebuild").check()
end

return M
