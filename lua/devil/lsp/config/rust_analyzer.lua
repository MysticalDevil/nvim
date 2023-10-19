local util = require("devil.lsp.util")

local opts = util.default_configs()

opts.filetypes = { "rust" }
opts.settings = {
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
}
opts.root_dir = function(fname)
  return require("lspconfig.util").root_pattern("Cargo.toml", "rust-project.json")(fname)
end

return util.set_on_setup(opts, "rust")
