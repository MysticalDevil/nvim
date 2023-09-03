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

return {
  on_setup = function(server)
    local ok_rt, rust_tools = pcall(require, "rust-tools")
    if not ok_rt then
      print("Failed to load rust tools, will set up `rust-analyzer` without `rust-tools`.")
      server.setup(opts)
    else
      rust_tools.setup({
        server = opts,
        dap = require("dap.nvim-dap.config.rust"),
      })
    end
  end,
}
