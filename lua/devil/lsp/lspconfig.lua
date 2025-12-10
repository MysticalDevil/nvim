local lspconfig = require("lspconfig")

local util = require("devil.lsp.util")

local noconfig_servers = {
  "dockerls",
  "golangci_lint_ls",
  "html",
  "jsonls",
  "lemminx", -- XML
  "neocmake",
  "nil_ls", -- Nix
  "phpactor",
  "ruff",
  "solargraph",
  "sourcekit",
  "standardrb",
  "tailwindcss",
  "taplo",
  "vala_ls",
  "vimls",
  "volar",
}

-- Configure the language server. The on_setup function must be implemented in the configuration file.
for _, name in ipairs(noconfig_servers) do
  lspconfig[name].setup({
    capabilities = util.common_capabilities(),
    flags = util.flags(),
    on_attach = util.default_on_attach,
  })
end

local lsp_servers = {
  "basedpyright",
  "bashls",
  "biome",
  "clangd",
  "cssls",
  "denols",
  "emmet_language_server",
  "gopls",
  "jsonls",
  "lua_ls",
  -- "pylsp",
  -- "rust_analyzer",
  "svelte",
  -- "tsserver",
  "vimls",
  "yamlls",
  "zls",
}

for _, server in ipairs(lsp_servers) do
  lspconfig[server].setup(require(("devil.lsp.config.%s"):format(server)))
end
