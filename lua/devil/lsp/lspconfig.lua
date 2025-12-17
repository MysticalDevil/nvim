local lspconfig = vim.lsp.config

local util = require("devil.lsp.util")

local noconfig_servers = {
  "biome",
  "denols",
  "dockerls",
  "emmet_language_server",
  "html",
  "jsonls",
  "lemminx", -- XML
  "neocmake",
  "nil_ls", -- Nix
  "ruff",
  "sourcekit",
  "tailwindcss",
  "taplo",
  "vimls",
  "vue_ls",
}

-- Configure the language server. The on_setup function must be implemented in the configuration file.
for _, name in ipairs(noconfig_servers) do
  lspconfig(name, {
    capabilities = util.common_capabilities(),
    flags = util.flags(),
    on_attach = util.default_on_attach,
  })
  vim.lsp.enable(name)
end

local lsp_servers = {
  -- "basedpyright",
  "bashls",
  "clangd",
  "cssls",
  -- "gopls",
  "jsonls",
  "lua_ls",
  "svelte",
  "tsgo",
  "ty",
  "vimls",
  "yamlls",
  "zls",
}

for _, server in ipairs(lsp_servers) do
  local user_opts_ok, user_opts = pcall(require, ("devil.lsp.config."):format(server))
  user_opts = user_opts_ok and user_opts or {}
  lspconfig(server, user_opts)
  vim.lsp.enable(server)
end
