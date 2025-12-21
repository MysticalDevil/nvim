local util = require("devil.lsp.util")

return vim.tbl_deep_extend("keep", util.default_configs(), {
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)",
    },
  },

  filetypes = { "sh", "zsh", "bash" },
})
