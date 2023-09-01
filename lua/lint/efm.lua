local linters = require("efmls-configs.linters")

local use_cppcheck = { "c", "cpp" }
local use_eslint = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" }
local use_shellcheck = { "sh", "zsh" }
local use_stylelint = { "css", "less", "sass", "scss" }

local languages = {
  go = { linters.golangci_lint },
  json = { linters.jq },
  lua = { linters.luacheck },
  python = { linters.pylint },
  rust = { linters.rustfmt },
  vim = { linters.vint },
}

---@param keys table
---@param value table
local insert_multi_keys = function(keys, value)
  for _, key in pairs(keys) do
    languages[key] = value
  end
end

insert_multi_keys(use_cppcheck, { linters.cppcheck })
insert_multi_keys(use_eslint, { linters.eslint })
insert_multi_keys(use_stylelint, { linters.stylelint })
insert_multi_keys(use_shellcheck, { linters.shellcheck })

local efmls_config = {
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { ".git/" },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
}

require("lspconfig").efm.setup(vim.tbl_extend("force", efmls_config, {}))
