local util = require("lsp.util")

local opts = util.default_configs()

opts.settings = {
  json = {
    schemas = require("schemastore").json.schemas(),
  },
}

return util.set_on_setup(opts)
