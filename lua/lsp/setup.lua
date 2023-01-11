local status, mason = pcall(require, "mason")
if not status then
  vim.notify("mason not found")
  return
end

local status, mason_config = pcall(require, "mason-lspconfig")
if not status then
  vim.notify("mason-lspconfig not found")
  return
end

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  vim.notify("lspconfig not found")
  return
end

local OS = vim.loop.os_uname().sysname
local lspServers = {
  "clangd",
  "cmake",
  "cssls",
  "dockerls",
  "gopls",
  "html",
  "jsonls",
  "pylsp",
  "rust_analyzer",
  "sumneko_lua",
  "tsserver",
  "taplo",
  "vimls",
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
  mason_config.setup({
    ensure_installed = lspServers,
  })
else
  table.insert(lspServers, "bashls")
  table.insert(lspServers, "solargraph")
  mason_config.setup({
    ensure_installed = lspServers,
  })
end

-- 安装列表
-- { key: 服务器名，value: 配置文件 }
-- key 必须为下列网址列出的 server name
-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local servers = {
  bashls = require("lsp.config.common"),
  clangd = require("lsp.config.common"),
  cmake = require("lsp.config.common"),
  cssls = require("lsp.config.css"),
  dockerls = require("lsp.config.common"),
  gopls = require("lsp.config.gopls"),
  html = require("lsp.config.common"),
  jsonls = require("lsp.config.json"),
  pylsp = require("lsp.config.common"),
  rust_analyzer = require("lsp.config.rust"),
  solargraph = require("lsp.config.common"),
  sumneko_lua = require("lsp.config.lua"),
  tsserver = require("lsp.config.typescript"),
  taplo = require("lsp.config.toml"),
  vimls = require("lsp.config.common"),
  yamlls = require("lsp.config.yaml"),
}

for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- 自定义初始化配置文件必须实现 on_setup 方法
    config.on_setup(lspconfig[name])
  else
    -- 使用默认参数
    lspconfig[name].setup({})
  end
end

require("lsp.ui")
