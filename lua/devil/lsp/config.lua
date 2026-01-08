local util = require("devil.lsp.util")

local servers = {
  -- no-config servers
  bashls = false,
  biome = false,
  cssls = false,
  denols = false,
  dockerls = false,
  emmet_language_server = false,
  elixirls = false,
  html = false,
  jsonls = false,
  lemminx = false,
  neocmake = false,
  nil_ls = false,
  phpactor = false,
  roslyn = false,
  ruff = false,
  tailwindcss = false,
  taplo = false,
  vimls = false,
  vue_ls = false,

  clangd = true,
  jdtls = true,
  lua_ls = true,
  sourcekit = true,
  svelte = true,
  tsgo = true,
  ty = true,
  yamlls = true,
  zls = true,
}

local function load_server_opts(server, selector)
  if not selector then
    return {}
  end

  local module_name = (selector == true) and server or selector
  local config_path = ("devil.lsp.config.%s"):format(module_name)

  local ok, opts = pcall(require, config_path)
  if not ok then
    if tostring(opts):match("module '.*' not found") then
      vim.notify(
        ("LSP config not found for %s (%s), fallback to default"):format(server, config_path),
        vim.log.levels.WARN
      )
    else
      vim.notify(
        ("Error loading LSP config for %s (%s):\n%s"):format(server, config_path, tostring(opts)),
        vim.log.levels.ERROR
      )
    end
    return {}
  end

  return opts or {}
end

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
