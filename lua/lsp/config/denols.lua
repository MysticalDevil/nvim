local lsp_util = require("lspconfig.util")
local util = require("lsp.util")
local opts = util.default_configs()

opts.filetypes =
  { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
opts.root_dir = function(fname)
  return lsp_util.root_pattern("deno.json", "deno.jsonc")(fname)
end
opts.setting = {
  deno = {
    enable = true,
    suggest = {
      imports = {
        hosts = {
          ["https://crux.land"] = true,
          ["https://deno.land"] = true,
          ["https://x.nest.land"] = true,
        },
      },
    },
    inlayHints = {
      parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
      parameterTypes = { enabled = true },
      variableTypes = { enabled = true, suppressWhenTypeMatchesName = true },
      propertyDeclarationTypes = { enabled = true },
      functionLikeReturnTypes = { enable = true },
      enumMemberValues = { enabled = true },
    },
  },
}
opts.single_file_support = false

return util.set_on_setup(opts)
