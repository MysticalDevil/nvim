local settings = require("devil.core.settings")

local function warn(msg)
  vim.schedule(function()
    vim.notify(msg, vim.log.levels.WARN)
  end)
end

local ok_mason, mason = pcall(require, "mason")
if not ok_mason then
  warn("LSP bootstrap skipped: mason.nvim is unavailable")
  return
end

local ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok_mason_lspconfig then
  warn("LSP bootstrap skipped: mason-lspconfig.nvim is unavailable")
  return
end

local ok_util, util = pcall(require, "devil.lsp.util")
if not ok_util then
  warn("LSP bootstrap skipped: devil.lsp.util failed to load")
  return
end

local ok_lsp_config, lsp_config = pcall(require, "devil.lsp.lsp_config")
if not ok_lsp_config then
  warn("LSP bootstrap skipped: devil.lsp.lsp_config failed to load")
  return
end

local function is_nixos()
  local f = io.open("/etc/NIXOS", "r")
  if f then
    io.close(f)
    return true
  end
  return false
end

--------------------------------------- Configures ------------------------------------------------

-- :h mason-default-settings
mason.setup({
  -- On NixOS, prefer system-managed language tools instead of Mason PATH injection.
  -- This avoids conflicting toolchains and keeps reproducibility aligned with Nix packages.
  PATH = is_nixos() and "skip" or "prepend",
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
  },
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

local disabled_handlers = {}
for server, _ in pairs(lsp_config.servers) do
  disabled_handlers[server] = function() end
end

mason_lspconfig.setup({
  ensure_installed = {},
  automatic_installation = false,
  automatic_enable = {
    exclude = {
      "rust_analyzer",
    },
  },
  handlers = disabled_handlers,
})

lsp_config.setup()
require("devil.lsp.ui")

if settings.lsp.inlay_hints.auto_enable then
  util.enable_inlay_hints_autocmd()
end
