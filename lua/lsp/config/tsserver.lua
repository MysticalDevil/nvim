local util = require("lsp.util")

local opts = util.default_configs()

return util.set_on_setup(opts, require("complete.setup").engine)
