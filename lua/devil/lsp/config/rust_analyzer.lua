local util = require("devil.lsp.util")

local M = {}

M.on_attach = util.default_on_attach
M.capabilities = util.common_capabilities()
M.flags = util.flags()

M.settings = {
  ["rust-analyzer"] = {
    inlayHints = {
      chainingHints = { enable = true },
      closingBraceHints = { enable = true, minLines = 25 },
      parameterHints = { enable = true },
      typeHints = { enable = true },
    },
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
}

return M
