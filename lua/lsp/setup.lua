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
  bashls = require("lsp.config.bash"),
  clangd = require("lsp.config.clangd"),
  clojure_lsp = require("lsp.config.clojure"),
  cssls = require("lsp.config.css"),
  emmet_ls = require("lsp.config.emmet"),
  eslint = require("lsp.config.eslint"),
  gopls = require("lsp.config.gopls"),
  jsonls = require("lsp.config.json"),
  lua_ls = require("lsp.config.lua"),
  pyright = require("lsp.config.python"),
  rust_analyzer = require("lsp.config.rust"),
  solargraph = require("lsp.config.ruby"),
  tsserver = require("lsp.config.typescript"),
  taplo = require("lsp.config.toml"),
  yamlls = require("lsp.config.yaml"),
}

print(servers["bashls"], "info")

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
