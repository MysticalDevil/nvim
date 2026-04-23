local M = {}
local util = require("devil.tools.lsp.util")
local notify = require("devil.shared.notify")

M.server_groups = {
  core = {
    lua_ls = true,
    jsonls = false,
    rumdl = true,
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
    phpantom_lsp = true,
    svelte = true,
    tsgo = true,
    vue_ls = false,
  },
  systems = {
    clangd = true,
    zls = true,
  },
  mobile = {
    ty = true,
  },
  enterprise = {
    jdtls = true,
    roslyn = false,
    ruby_lsp = false,
  },
  experimental = {
    expert = false,
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

local enabled_groups = {
  core = true,
  web = true,
  systems = true,
  mobile = false,
  enterprise = false,
  experimental = true,
}

local function active_servers()
  local servers = {}
  for group_name, is_enabled in pairs(enabled_groups) do
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
  local config_path = ("devil.tools.lsp.servers.%s"):format(module_name)

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
      util.set_lsp_foldexpr(client, bufnr)
      util.configure_document_color(client, bufnr)
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
