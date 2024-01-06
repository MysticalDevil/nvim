local util = require("devil.lsp.util")

local opts = util.default_configs()

opts.filetypes =
  { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
opts.settings = {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}
opts.single_file_support = (function()
  local current_dir = vim.fn.getcwd()
  local deno_json_path = ("%s/deno.json"):format(current_dir)

  return not (vim.fn.filereadable(deno_json_path) == 1)
end)()

return opts
