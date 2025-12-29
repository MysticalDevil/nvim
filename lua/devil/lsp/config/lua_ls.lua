local util = require("devil.lsp.util")

---@type vim.lsp.Config
return vim.tbl_deep_extend("keep", util.default_configs(), {
  settings = {
    Lua = {
      runtime = {
        -- Tell the langurage server which version of Lua you're using
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
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
      completion = {
        callSnippet = "Replace",
      },
    },
  },
  single_file_support = true,
})
