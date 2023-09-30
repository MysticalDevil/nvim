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
    },
  },
}

return util.on_setup(opts, require("complete.setup").engine, "rust")
