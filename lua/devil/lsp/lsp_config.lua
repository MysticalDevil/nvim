local M = {}
local util = require("devil.lsp.util")
local notify = require("devil.utils.notify")
local settings = require("devil.core.settings")

M.server_groups = {
  core = {
    lua_ls = true,
    jsonls = false,
    yamlls = true,
    taplo = false,
    bashls = false,
    vimls = false,
  },
  web = {
    biome = false,
    denols = false,
    emmet_language_server = false,
    html = false,
    svelte = true,
    tsgo = true,
    vue_ls = false,
  },
  systems = {
    clangd = true,
    sourcekit = true,
    zls = true,
  },
  mobile = {
    ty = true,
  },
  enterprise = {
    jdtls = true,
    roslyn = false,
    ruby_lsp = false,
    phpactor = false,
  },
  experimental = {
    elixirls = false,
    lemminx = false,
    mesonlsp = false,
    neocmake = false,
    nil_ls = false,
    qmlls = false,
    ruff = false,
    vala_ls = false,
    dockerls = false,
  },
}

local function enabled_groups()
  local groups = settings.lsp.groups or {}
  return {
    core = groups.core ~= false,
    web = groups.web ~= false,
    systems = groups.systems ~= false,
    mobile = groups.mobile == true,
    enterprise = groups.enterprise == true,
    experimental = groups.experimental == true,
  }
end

local function active_servers()
  local servers = {}
  local groups = enabled_groups()
  for group_name, is_enabled in pairs(groups) do
    if is_enabled and M.server_groups[group_name] then
      servers = vim.tbl_deep_extend("force", servers, M.server_groups[group_name])
    end
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
      notify.error(("Error loading LSP config for %s:\n%s"):format(server, opts))
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
