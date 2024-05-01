local util = require("devil.lsp.util")
local opts = util.default_configs()

local lsp_util = require("lspconfig.util")

opts.settings = {}

opts.filetypes = {
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "typescript",
  "typescript.tsx",
  "typescriptreact",
  "astro",
  "svelte",
  "vue",
}

opts.root_dir = function(fname)
  return lsp_util.root_pattern("biome.json", "biome.jsonc")(fname)
end

opts.single_file_support = false

return opts
