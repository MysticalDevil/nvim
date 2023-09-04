local status, lsp_zero = pcall(require, "lsp-zero")
if not status then
  vim.notify("lsp-zero.nvim not found", "error")
  return
end

local lsp = lsp_zero.preset({})
local mason = require("mason")
local lspconfig = require("lspconfig")

--------------------------------------- Configures ------------------------------------------------

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

local lsp_servers = require("lsp.check")

-- :h mason-default-settings
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- Install list
-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local servers = {
  bashls = require("lsp.config.bashls"),
  clangd = require("lsp.config.clangd"),
  clojure_lsp = require("lsp.config.clojure_lsp"),
  cssls = require("lsp.config.cssls"),
  efm = require("lsp.config.efm"),
  emmet_ls = require("lsp.config.emmet_ls"),
  eslint = require("lsp.config.eslint"),
  gopls = require("lsp.config.gopls"),
  jsonls = require("lsp.config.jsonls"),
  lua_ls = require("lsp.config.lua_ls"),
  pyright = require("lsp.config.pyright"),
  rust_analyzer = require("lsp.config.rust_analyzer"),
  solargraph = require("lsp.config.solargraph"),
  -- tsserver = require("lsp.config.tsserver"),
  taplo = require("lsp.config.taplo"),
  yamlls = require("lsp.config.yamlls"),
}

-- Configure the language server. The on_setup function must be implemented in the configuration file.
for _, name in ipairs(lsp_servers) do
  local config = servers[name] or require("lsp.config.common")
  if type(config) == "table" and config.on_setup ~= nil then
    config.on_setup(lspconfig[name])
  else
    config.on_setup(lspconfig[name])
  end
end

require("lsp.ui")

lsp.setup()
