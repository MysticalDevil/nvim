local util = require("lsp.util")

local opts = util.default_configs()

opts.settings = {
  json = {
    schemas = require("schemastore").json.schemas(),
  },
}

return util.on_setup(opts, require("complete.setup").engine)
