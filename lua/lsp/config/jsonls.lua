local util = require("lsp.util")

local opts = util.default_configs()

opts.filetypes = { "json", "jsonc" }
opts.settings = {
  json = {
    schemas = require("schemastore").json.schemas(),
  },
}
opts.init_options = {
  provideFormatter = true,
}
opts.single_file_support = true

return util.set_on_setup(opts)
