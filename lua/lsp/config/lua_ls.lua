local runtime_path = vim.split(package.path, ";", {})
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/>/init.lua")

local util = require("lsp.util")

local opts = util.default_configs()

opts.filetypes = { "lua" }
opts.settings = {
  Lua = {
    runtime = {
      -- Tell the langurage server which version of Lua you're using
      version = "LuaJIT",
      -- Setup your lua path
      path = runtime_path,
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { "vim" },
    },
    workspace = {
      -- Make the server aware of Neovim runtimne files
      libiary = { vim.api.nvim_get_runtime_file("", true), vim.env.VIMRUNTIME },
      checkThirdParty = false,
    },
    -- Do not send telemetry data containing a randomized but unique identifier
    telemetry = {
      enable = false,
    },
    hint = {
      enable = true,
      arrayIndex = "Auto",
      await = true,
      paramName = "All",
      paramType = true,
      semicolon = "SameLine",
      setType = false,
    },
  },
}
opts.root_dir = require("lspconfig.util").root_pattern(
  ".luarc.json",
  ".luarc.jsonc",
  ".luacheckrc",
  ".stylua.toml",
  "stylua.toml",
  "selene.toml",
  "selene.yml",
  ".git"
)
opts.single_file_support = true

return util.set_on_setup(opts, "lua")
