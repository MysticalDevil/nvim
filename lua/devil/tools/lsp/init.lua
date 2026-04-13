local function warn(msg)
  vim.schedule(function()
    vim.notify(msg, vim.log.levels.WARN)
  end)
end

local deps = {
  {
    key = "mason",
    module = "mason",
    error = "LSP bootstrap skipped: mason.nvim is unavailable",
  },
  {
    key = "mason_lspconfig",
    module = "mason-lspconfig",
    error = "LSP bootstrap skipped: mason-lspconfig.nvim is unavailable",
  },
  {
    key = "util",
    module = "devil.tools.lsp.util",
    error = "LSP bootstrap skipped: devil.tools.lsp.util failed to load",
  },
  {
    key = "lsp_config",
    module = "devil.tools.lsp.lsp_config",
    error = "LSP bootstrap skipped: devil.tools.lsp.lsp_config failed to load",
  },
}

local loaded = {}
for _, dep in ipairs(deps) do
  local ok, mod = pcall(require, dep.module)
  if not ok then
    warn(dep.error)
    return
  end
  loaded[dep.key] = mod
end

local mason = loaded.mason
local mason_lspconfig = loaded.mason_lspconfig
local util = loaded.util
local lsp_config = loaded.lsp_config

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
  automatic_enable = false,
  handlers = disabled_handlers,
})

lsp_config.setup()
require("devil.tools.lsp.ui")
util.enable_dynamic_capability_attach()
util.enable_lsp_folding_autocmd()

if true then
  util.enable_inlay_hints_autocmd()
end
