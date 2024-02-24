local lspconfig = require("lspconfig")

local util = require("devil.lsp.util")

local noconfig_servers = {
  "clojure_lsp",
  "dockerls",
  "eslint",
  "golangci_lint_ls",
  "groovyls",
  "html",
  "jsonls",
  "kotlin_language_server",
  "lemminx", -- XML
  "nil_ls", -- Nix
  "omnisharp",
  "perlnavigator",
  "phpactor",
  "racket_langserver",
  "ruff_lsp",
  "solargraph",
  "standardrb",
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
  "clangd",
  "dartls",
  "denols",
  "eslint",
  "gopls",
  "lua_ls",
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

lspconfig.bashls.setup({
  capabilities = util.common_capabilities(),
  flags = util.flags(),
  on_attach = util.default_on_attach,

  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)",
    },
  },

  filetypes = { "sh", "zsh", "bash" },
})

lspconfig.cssls.setup({
  capabilities = util.common_capabilities(),
  flags = util.flags(),
  on_attach = util.default_on_attach,

  settings = {
    css = {
      validate = true,
      -- tailwindcss
      lint = {
        unknownAtRules = "ignore",
      },
    },
    less = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
    scss = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },

  filetypes = { "css", "scss", "less" },
})

lspconfig.emmet_ls.setup({
  capabilities = util.common_capabilities(),
  flags = util.flags(),
  on_attach = util.default_on_attach,

  filetypes = {
    "astro",
    "css",
    "eruby",
    "html",
    "htmldjango",
    "javascriptreact",
    "less",
    "pug",
    "sass",
    "scss",
    "svelte",
    "typescriptreact",
    "vue",
  },
})

lspconfig.jsonls.setup({
  capabilities = util.common_capabilities(),
  flags = util.flags(),
  on_attach = util.default_on_attach,

  filetypes = { "json", "jsonc" },
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      format = { enable = true },
      validate = { enable = true },
    },
  },
  init_options = {
    provideFormatter = true,
  },
  single_file_support = true,
})
