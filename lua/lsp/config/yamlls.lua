local util = require("lsp.util")

local opts = util.default_configs()

local url = "https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"

opts.settings = {
  yaml = {
    format = {
      enable = true,
    },
    schemas = {
      [url] = "conf/**/*catalog*",
      ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
    },
  },
}

return util.on_setup(opts, require("complete.setup").engine)
