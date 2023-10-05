local util = require("lsp.util")

local servers_list = {
  "clangd",
  "clojure_lsp",
  "denols",
  "kotlin_language_server",
  "lua_ls",
  "taplo",
  "zls",
}

local required_npm = {
  "cssls",
  "dockerls",
  "emmet_ls",
  "eslint",
  "html",
  "jsonls",
  "tsserver",
  "vimls",
  "volar",
  "yamlls",
}

if util.check_os() == "Linux" then
  table.insert(required_npm, "bashls")
end

local required_cargo = { "fennel_language_server", "neocmake", "pylyzer" }

local required_go = { "gopls" }

local required_pip = { "cmake" }

local required_gem = { "ruby_ls" }

local insert_to = function(status, insert_list)
  if status then
    for _, server in ipairs(insert_list) do
      table.insert(servers_list, server)
    end
  end
end

insert_to(util.node_installed, required_npm)
insert_to(util.rust_installed, required_cargo)
insert_to(util.go_installed, required_go)
insert_to(util.python_installed, required_pip)
insert_to(util.ruby_installed, required_gem)

return servers_list
