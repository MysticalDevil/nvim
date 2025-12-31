local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

local util = require("devil.lsp.util")

--------------------------------------- Configures ------------------------------------------------

-- :h mason-default-settings
mason.setup({
  ui = {
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
  automatic_enable = {
    exclude = {
      "rust_analyzer",
    },
  },
  handlers = {
    jdtls = function() end,
  },
})

require("devil.lsp.config")
require("devil.lsp.diag")
require("devil.lsp.clangd_native").setup()

util.enable_inlay_hints_autocmd()
