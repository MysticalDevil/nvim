return {
  {
    "mrcjkb/rustaceanvim",
    version = "^7",
    ft = { "rust" },
    init = function()
      local util = require("devil.lsp.util")
      local common_on_attach = util.default_on_attach
      local common_caps = util.common_capabilities()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            common_on_attach(client, bufnr)
          end,
          capabilities = common_caps,
          default_settings = require("devil.lsp.config.rust_analyzer"),
        },
      }
    end,
  },
  {
    "saecki/crates.nvim",
    tag = "stable",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      src = {
        coq = {
          enabled = true,
          name = "crates.nvim",
        },
      },
    },
  },
}
