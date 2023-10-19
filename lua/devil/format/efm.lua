local formatters = require("efmls-configs.formatters")

local use_clang_tidy = { "c", "cpp" }
local use_prettier =
  { "css", "less", "sass", "scss", "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" }
local use_beautysh = { "sh", "zsh" }

local languages = {
  go = { formatters.gofmt, formatters.goimports, formatters.golines },
  lua = { formatters.stylua },
  python = { formatters.black, formatters.isort },
  rust = { formatters.rustfmt },
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
