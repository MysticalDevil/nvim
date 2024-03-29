local util = require("devil.lsp.util")
local opts = util.default_configs()

opts.filetypes = { "json", "jsonc" }
opts.settings = {
  json = {
    schemas = require("schemastore").json.schemas(),
    format = { enable = true },
    validate = { enable = true },
  },
}
opts.init_options = {
  provideFormatter = true,
}
opts.single_file_support = true

return opts
