local status, mason = pcall(require, "mason")
if not status then
  vim.notify("mason.nvim not found", "error")
  return
end

local mason_config = require("mason-lspconfig")

local lspconfig = require("lspconfig")

local lsp_signature = require("lsp_signature")

local navic = require("nvim-navic")

-- local coq = require("coq")

local OS = vim.loop.os_uname().sysname
local lspServers = {
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
  "pylsp",
  "rust_analyzer",
  "tsserver",
  "taplo",
  "vimls",
  "vuels",
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
  bashls = require("lsp.config.bash"),
  clangd = require("lsp.config.clangd"),
  cmake = require("lsp.config.common"),
  cssls = require("lsp.config.css"),
  cssmodules_ls = require("lsp.config.common"),
  dockerls = require("lsp.config.common"),
  emmet_ls = require("lsp.config.emmet"),
  gopls = require("lsp.config.gopls"),
  html = require("lsp.config.common"),
  jsonls = require("lsp.config.json"),
  lua_ls = require("lsp.config.lua"),
  pylsp = require("lsp.config.common"),
  rust_analyzer = require("lsp.config.rust"),
  solargraph = require("lsp.config.common"),
  tsserver = require("lsp.config.typescript"),
  taplo = require("lsp.config.toml"),
  vimls = require("lsp.config.common"),
  vuels = require("lsp.config.common"),
  yamlls = require("lsp.config.yaml"),
  zls = require("lsp.config.common"),
}

for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- 自定义初始化配置文件必须实现 on_setup 方法
    config.on_setup(lspconfig[name])
  else
    -- 使用默认参数
    lspconfig[name].setup({
      on_attach = function(client, bufnr)
        lsp_signature.on_attach({
          bind = true,
          handler_opts = {
            border = "rounded",
          },
        }, bufnr)
        navic.attach(client, bufnr)
      end,
      -- coq.lsp_ensure_capabilities(),
    })
  end
end

require("lsp.ui")
