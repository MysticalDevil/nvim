local util = require("devil.lsp.util")

---@type vim.lsp.Config
return vim.tbl_deep_extend("keep", util.default_configs(), {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        allFeatures = true,
        overrideCommand = {
          "cargo",
          "clippy",
          "--workspace",
          "--message-format=json",
          "--all-targets",
          "--all-features",
        },
      },
      cargo = {
        autoReload = true,
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
      diagnostics = {
        enable = false,
      },
    },
  },
})
