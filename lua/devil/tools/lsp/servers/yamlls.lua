local url = "https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"

---@type vim.lsp.Config
return {
  settings = {
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
  },
  single_file_support = true,
}
