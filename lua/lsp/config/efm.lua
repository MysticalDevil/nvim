local util = require("lsp.util")
local opts = util.default_configs()

opts.filetypes = {
  "cpp",
}

opts.single_file_support = false

opts.autostart = false

return util.set_on_setup(opts, require("complete.setup").engine)
