local status, lsp_zero = pcall(require, "lsp-zero")
if not status then
  vim.notify("lsp-zero.nvim not found", "error")
  return
end

local lsp = lsp_zero.preset({})

local mason = require("mason")
local mason_config = require("mason-lspconfig")

local lspconfig = require("lspconfig")

local lsp_signature = require("lsp_signature")

local navic = require("nvim-navic")

--------------------------------------- Configures ------------------------------------------------

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

local OS = vim.loop.os_uname().sysname
local lsp_servers = {
  "bufls",
  "clangd",
  "cmake",
  "cssls",
  "cssmodules_ls",
  "dockerls",
  "emmet_ls",
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "omnisharp",
  "pylsp",
  "rust_analyzer",
  "tsserver",
  "taplo",
  "vimls",
  "volar",
  "yamlls",
}

-- :h mason-default-settings
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- mason-lspconfig uses the `lspconfig` servers names in the APIs it exposes
-- - not `mson.nvim` package names
if OS ~= "Linux" then
  lsp.ensure_installed(lsp_servers)
else
  table.insert(lsp_servers, "bashls")
  lsp.ensure_installed(lsp_servers)
end

-- 安装列表
-- { key: 服务器名，value: 配置文件 }
-- key 必须为下列网址列出的 server name
-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local servers = {
  bashls = require("lsp.config.bash"),
  clangd = require("lsp.config.clangd"),
  cssls = require("lsp.config.css"),
  emmet_ls = require("lsp.config.emmet"),
  gopls = require("lsp.config.gopls"),
  jsonls = require("lsp.config.json"),
  lua_ls = require("lsp.config.lua"),
  rust_analyzer = require("lsp.config.rust"),
  tsserver = require("lsp.config.typescript"),
  taplo = require("lsp.config.toml"),
  yamlls = require("lsp.config.yaml"),
}

for _, name in ipairs(lsp_servers) do
  local config = servers[name] or require("lsp.config.common")
  if type(config) == "table" and config.on_setup ~= nil then
    config.on_setup(lspconfig[name])
  else
    config.on_setup(lspconfig[name])
  end
end

require("lsp.ui")

lsp.setup()
