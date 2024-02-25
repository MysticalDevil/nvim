local formatters = require("efmls-configs.formatters")
local linters = require("efmls-configs.linters")

local use_clang_tidy = { "c", "cpp" }
local use_prettier =
  { "css", "less", "sass", "scss", "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" }
local use_beautysh = { "sh", "zsh" }
local use_cppcheck = { "c", "cpp" }
local use_eslint = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" }
local use_shellcheck = { "sh", "zsh" }
local use_stylelint = { "css", "less", "sass", "scss" }

local languages = {
  go = { formatters.gofmt, formatters.goimports, formatters.golines, linters.golangci_lint },
  json = { linters.jq },
  lua = { formatters.stylua, linters.selene },
  python = { formatters.ruff, linters.ruff },
  rust = { formatters.rustfmt, linters.rustfmt },
  vim = { linters.vint },
}

---@param keys table
---@param value table
local insert_multi_keys = function(keys, value)
  for _, key in pairs(keys) do
    languages[key] = value
  end
end

insert_multi_keys(use_clang_tidy, { formatters.clang_tidy })
insert_multi_keys(use_prettier, { formatters.prettier })
insert_multi_keys(use_beautysh, { formatters.beautysh })
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
