local lspconfig = require("lspconfig")

local util = require("devil.lsp.util")

require("devil.lsp.config.carbon")

local noconfig_servers = {
  "biome",
  "clojure_lsp",
  "cssmodules_ls",
  "dockerls",
  "golangci_lint_ls",
  "groovyls",
  "html",
  "jsonls",
  "kotlin_language_server",
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
  "omnisharp",
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
