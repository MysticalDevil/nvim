local util = require("lsp.util")

local opts = util.default_configs()

opts.filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" }

return util.set_on_setup(opts, require("complete.setup").engine)
