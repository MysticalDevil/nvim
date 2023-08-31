local util = require("lsp.util")

local opts = util.default_configs

opts.settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  }

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
