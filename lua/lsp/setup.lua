local status, lsp_zero = pcall(require, "lsp-zero")
if not status then
  vim.notify("lsp-zero.nvim not found", "error")
  return
end

local lsp = lsp_zero.preset({})
local mason = require("mason")
local lspconfig = require("lspconfig")

local util = require("lsp.util")

--------------------------------------- Configures ------------------------------------------------

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

local lsp_servers = require("lsp.check")
table.insert(lsp_servers, "rust_analyzer")
table.insert(lsp_servers, "v_analyzer")
table.insert(lsp_servers, "racket_langserver")

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
  kotlin_language_server = require("lsp.config.kotlin_language_server"),
  lua_ls = require("lsp.config.lua_ls"),
  pylyzer = require("lsp.config.pylyzer"),
  racket_langserver = require("lsp.config.racket_langserver"),
  rust_analyzer = require("lsp.config.rust_analyzer"),
  solargraph = require("lsp.config.solargraph"),
  taplo = require("lsp.config.taplo"),
  tsserver = require("lsp.config.tsserver"),
  v_analyzer = require("lsp.config.v_analyzer"),
  vimls = require("lsp.config.vimls"),
  yamlls = require("lsp.config.yamlls"),
  zls = require("lsp.config.zls"),
}

local common_config = require("lsp.config.common")

-- Configure the language server. The on_setup function must be implemented in the configuration file.
for _, name in ipairs(lsp_servers) do
  local config = servers[name] or common_config
  if type(config) == "table" and config.on_setup ~= nil then
    config.on_setup(lspconfig[name])
  else
    config.on_setup(lspconfig[name])
  end
end

require("lsp.ui")

util.enable_inlay_hints_autocmd()

lsp.setup()
