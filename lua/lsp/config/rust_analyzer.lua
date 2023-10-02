local util = require("lsp.util")

local opts = util.default_configs()

opts.settings = {
  rust_analyzer = {
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
  },
}

return util.set_on_setup(opts, "rust")
