local lspconfig = vim.lsp.config

local util = require("devil.lsp.util")

local noconfig_servers = {
  "biome",
  "denols",
  "dockerls",
  "emmet_language_server",
  "golangci_lint_ls",
  "html",
  "jsonls",
  "lemminx", -- XML
  "neocmake",
  "nil_ls", -- Nix
  "ruff",
  "sourcekit",
  "tailwindcss",
  "taplo",
  "tsgo",
  "vimls",
  "vue_ls",
}

-- Configure the language server. The on_setup function must be implemented in the configuration file.
for _, name in ipairs(noconfig_servers) do
  lspconfig[name] = {
    capabilities = util.common_capabilities(),
    flags = util.flags(),
    on_attach = util.default_on_attach,
  }
  vim.lsp.enable(name)
end

local lsp_servers = {
  "basedpyright",
  "bashls",
  "clangd",
  "cssls",
  "gopls",
  "jsonls",
  "lua_ls",
  -- "pylsp",
  -- "rust_analyzer",
  "svelte",
  "vimls",
  "yamlls",
  "zls",
}

for _, server in ipairs(lsp_servers) do
  lspconfig[server] = require(("devil.lsp.config.%s"):format(server))
  vim.lsp.enable(server)
end
