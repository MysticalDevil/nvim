local util = require("devil.lsp.util")

local noconfig_servers = {
  "bashls",
  "biome",
  "cssls",
  "denols",
  "dockerls",
  "emmet_language_server",
  "html",
  "jsonls",
  "lemminx", -- XML
  "neocmake",
  "nil_ls", -- Nix
  "phpactor",
  "ruff",
  "sourcekit",
  "tailwindcss",
  "taplo",
  "vimls",
  "vue_ls",
}

-- Configure the language server. The on_setup function must be implemented in the configuration file.
for _, name in ipairs(noconfig_servers) do
  vim.lsp.config(name, {
    capabilities = util.common_capabilities(),
    flags = util.flags(),
    on_attach = util.default_on_attach,
  })
  vim.lsp.enable(name)
end

local configured_servers = {
  ["jsonls"] = "jsonls",
  ["lua_ls"] = "lua_ls",
  ["svelte"] = "svelte",
  ["tsgo"] = "tsgo",
  ["ty"] = "ty",
  ["yamlls"] = "yamlls",
  ["zls"] = "zls",
}

for server, config_name in pairs(configured_servers) do
  local config_path = ("devil.lsp.config.%s"):format(config_name)
  local success, opts = pcall(require, config_path)

  if not success then
    if opts:match("module '.*' not found") then
      vim.notify(("LSP Config not found for: %s, use default"):format(server), vim.log.levels.WARN)
      opts = {}
    else
      vim.notify(("Error loadding LSP config for %s:\n"):format(server), vim.log.levels.ERROR)
      opts = {}
    end
  end

  opts.capabilities = vim.tbl_deep_extend("keep", opts.capabilities or {}, util.common_capabilities())
  local old_on_attach = opts.on_attach
  opts.on_attach = function(client, bufnr)
    util.default_on_attach(client, bufnr)
    if old_on_attach then
      old_on_attach(client, bufnr)
    end
  end

  vim.lsp.config(server, opts)
  vim.lsp.enable(server)
end
