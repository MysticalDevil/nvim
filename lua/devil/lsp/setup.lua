local mason = require("mason")
local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

local util = require("devil.lsp.util")

--------------------------------------- Configures ------------------------------------------------

local function arr_extend(origin_arr, added_arr)
  for i = #added_arr, 1, -1 do
    origin_arr[#origin_arr + 1] = added_arr[i]
  end
  return origin_arr
end

local lsp_servers = require("devil.lsp.check")
lsp_servers = arr_extend(lsp_servers, {
  -- "csharp_ls",
  -- "dartls",
  "groovyls",
  "nil_ls",
  "omnisharp",
  "perlpls",
  "phpactor",
  "racket_langserver",
  "rust_analyzer",
  "v_analyzer",
  "vala_ls",
})

-- :h mason-default-settings
mason.setup({
  -- Whether to automatically check for new versions when opening the :Mason window.
  check_outdated_packages_on_open = true,

  -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
  border = "rounded",

  -- Width of the window. Accepts:
  -- - Integer greater than 1 for fixed width.
  -- - Float in the range of 0-1 for a percentage of screen width.
  width = 0.8,

  -- Height of the window. Accepts:
  -- - Integer greater than 1 for fixed height.
  -- - Float in the range of 0-1 for a percentage of screen height.
  height = 0.9,

  ui = {
    icons = {
      -- The list icon to use for installed packages.
      package_installed = "✓",
      -- The list icon to use for packages that are installing, or queued for installation.
      package_pending = "➜",
      -- The list icon to use for packages that are not installed.
      package_uninstalled = "✗",
    },
  },
})

mason_lspconfig.setup({
  ensure_installed = {},
  automatic_installation = false,
  handlers = {
    jdtls = function() end,
  },
})

-- Install list
-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local servers = {
  bashls = require("devil.lsp.config.bashls"),
  -- csharp_ls = require("devil.lsp.config.csharp_ls"),
  clangd = require("devil.lsp.config.clangd"),
  clojure_lsp = require("devil.lsp.config.clojure_lsp"),
  cssls = require("devil.lsp.config.cssls"),
  denols = require("devil.lsp.config.denols"),
  emmet_ls = require("devil.lsp.config.emmet_ls"),
  eslint = require("devil.lsp.config.eslint"),
  fennel_language_server = require("devil.lsp.config.fennel_language_server"),
  gopls = require("devil.lsp.config.gopls"),
  groovyls = require("devil.lsp.config.groovyls"),
  jsonls = require("devil.lsp.config.jsonls"),
  kotlin_language_server = require("devil.lsp.config.kotlin_language_server"),
  lua_ls = require("devil.lsp.config.lua_ls"),
  nil_ls = require("devil.lsp.config.nil_ls"),
  omnisharp = require("devil.lsp.config.omnisharp"),
  perlpls = require("devil.lsp.config.perlpls"),
  phpactor = require("devil.lsp.config.phpactor"),
  pylsp = require("devil.lsp.config.pylsp"),
  racket_langserver = require("devil.lsp.config.racket_langserver"),
  rust_analyzer = require("devil.lsp.config.rust_analyzer"),
  solargraph = require("devil.lsp.config.solargraph"),
  taplo = require("devil.lsp.config.taplo"),
  tsserver = require("devil.lsp.config.tsserver"),
  v_analyzer = require("devil.lsp.config.v_analyzer"),
  vala_ls = require("devil.lsp.config.vala_ls"),
  vimls = require("devil.lsp.config.vimls"),
  yamlls = require("devil.lsp.config.yamlls"),
  zls = require("devil.lsp.config.zls"),
}

local common_config = require("devil.lsp.config.common")

-- Configure the language server. The on_setup function must be implemented in the configuration file.
for _, name in ipairs(lsp_servers) do
  local config = servers[name] or common_config
  if type(config) == "table" and config.on_setup ~= nil then
    config.on_setup(lspconfig[name])
  else
    config.on_setup(lspconfig[name])
  end
end

require("devil.lsp.ui")
require("devil.lsp.attach")

util.enable_inlay_hints_autocmd()
