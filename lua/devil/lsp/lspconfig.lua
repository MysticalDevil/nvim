local lspconfig = require("lspconfig")

local util = require("devil.lsp.util")

local noconfig_servers = {
  "clojure_lsp",
  "cssmodules_ls",
  "dockerls",
  "eslint",
  "golangci_lint_ls",
  "groovyls",
  "html",
  "jsonls",
  "kotlin_language_server",
  "lemminx", -- XML
  "neocmake",
  "nil_ls", -- Nix
  "perlnavigator",
  "phpactor",
  "racket_langserver",
  "ruff_lsp",
  "solargraph",
  "standardrb",
  "tailwindcss",
  "taplo",
  "v_analyzer",
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
  "bashls",
  "clangd",
  "cssls",
  "dartls",
  "denols",
  "emmet_language_server",
  "eslint",
  "gopls",
  "jsonls",
  "lua_ls",
  "omnisharp",
  "pylsp",
  -- "rust_analyzer",
  -- "tsserver",
  "vimls",
  "yamlls",
  "zls",
}

for _, server in ipairs(lsp_servers) do
  lspconfig[server].setup(require(("devil.lsp.config.%s"):format(server)))
end
