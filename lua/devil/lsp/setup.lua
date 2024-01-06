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

local noconfig_servers = {
  "clojure_lsp",
  "kotlin_language_server",
  "taplo",
  "nil_ls",
  "perlpls",
  "phpactor",
  "racket_langserver",
  "v_analyzer",
  "vala_ls",
  "dockerls",
  "eslint",
  "html",
  "vimls",
  "volar",
  "solargraph",
  "groovyls",
  "omnisharp",
}

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

-- Configure the language server. The on_setup function must be implemented in the configuration file.
for _, name in ipairs(noconfig_servers) do
  lspconfig[name].setup({
    capabilities = util.common_capabilities(),
    flags = util.flags(),
    on_attach = util.default_on_attach,
  })
end

require("devil.lsp.ui")
require("devil.lsp.attach")

require("devil.lsp.lspconfig")

util.enable_inlay_hints_autocmd()
