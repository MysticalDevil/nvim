local M = {}
local util = require("devil.lsp.util")
local settings = require("devil.core.settings")

M.server_layers = {
  stable = {
    -- no-config servers
    bashls = false,
    biome = false,
    dockerls = false,
    emmet_language_server = false,
    html = false,
    jsonls = false,
    lemminx = false,
    mesonlsp = false,
    neocmake = false,
    nil_ls = false,
    phpactor = false,
    qmlls = false,
    roslyn = false,
    ruff = false,
    taplo = false,
    vala_ls = false,
    vimls = false,
    vue_ls = false,

    clangd = true,
    jdtls = true,
    lua_ls = true,
    sourcekit = true,
    svelte = true,
    tsgo = true,
    yamlls = true,
    zls = true,
  },
  experimental = {
    denols = false,
    elixirls = false,
    ruby_lsp = false,
    ty = true,
  },
}

local function active_servers()
  local servers = vim.tbl_deep_extend("force", {}, M.server_layers.stable)
  if settings.lsp.servers.include_experimental then
    servers = vim.tbl_deep_extend("force", servers, M.server_layers.experimental)
  end
  return servers
end

M.servers = active_servers()

local function refresh_servers()
  M.servers = active_servers()
  return M.servers
end

local function load_server_opts(server, selector)
  if not selector then
    return {}
  end

  local module_name = (selector == true) and server or selector
  local config_path = ("devil.lsp.config.%s"):format(module_name)

  local ok, opts = pcall(require, config_path)
  if not ok then
    if not tostring(opts):match("module '.*' not found") then
      vim.notify(("Error loading LSP config for %s:\n%s"):format(server, opts), vim.log.levels.ERROR)
    end
    return {}
  end

  return opts or {}
end

function M.setup()
  local servers = refresh_servers()
  for server, selector in pairs(servers) do
    local base = {
      capabilities = util.common_capabilities(),
      flags = util.flags(),
      on_attach = util.default_on_attach,
    }

    local extra = load_server_opts(server, selector)

    local opts = vim.tbl_deep_extend("force", base, extra)

    local old_on_attach = extra.on_attach
    opts.on_attach = function(client, bufnr)
      util.default_on_attach(client, bufnr)
      if old_on_attach then
        old_on_attach(client, bufnr)
      end
    end

    opts.capabilities = vim.tbl_deep_extend("keep", opts.capabilities or {}, util.common_capabilities())

    vim.lsp.config(server, opts)
    vim.lsp.enable(server)
  end
end

return M
