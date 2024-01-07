local lspconfig = require("lspconfig")
local lsp_utils = require("lspconfig.util")

local util = require("devil.lsp.util")

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

lspconfig.clangd.setup(require("devil.lsp.config.clangd"))
lspconfig.dartls.setup(require("devil.lsp.config.dartls"))
lspconfig.dartls.setup(require("devil.lsp.config.denols"))
lspconfig.eslint.setup(require("devil.lsp.config.eslint"))
lspconfig.lua_ls.setup(require("devil.lsp.config.lua_ls"))
lspconfig.pylsp.setup(require("devil.lsp.config.pylsp"))
lspconfig.vimls.setup(require("devil.lsp.config.vimls"))
lspconfig.yamlls.setup(require("devil.lsp.config.yamlls"))
lspconfig.zls.setup(require("devil.lsp.config.zls"))
lspconfig.gopls.setup(require("devil.lsp.config.gopls"))
-- lspconfig.rust_analyzer.setup(require("devil.lsp.config.rust_analyzer"))
-- lspconfig.tsserver.setup(require("devil.lsp.config.tsserver"))

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
