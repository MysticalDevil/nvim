local util = require("devil.lsp.util")

local opts = util.default_configs()

local url = "https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"

opts.filetypes = { "yaml", "yaml.docker-compose" }
opts.settings = {
  yaml = {
    keyOrdering = false,
    format = {
      enable = true,
    },
    validate = true,
    schemas = {
      [url] = "conf/**/*catalog*",
      ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
    },
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
  },
}
opts.single_file_support = true

return opts
