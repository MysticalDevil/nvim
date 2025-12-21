local util = require("devil.lsp.util")

---@type vim.lsp.Config
return vim.tbl_deep_extend("keep", util.default_config(), {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      format = { enable = true },
      validate = { enable = true },
    },
  },
  init_options = {
    provideFormatter = true,
  },
  single_file_support = true,
})
