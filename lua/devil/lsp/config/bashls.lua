local util = require("devil.lsp.util")
local opts = util.default_configs()

opts.settings = {
  bashIde = {
    globPattern = "*@(.sh|.inc|.bash|.command)",
  },
}

opts.filetypes = { "sh", "zsh", "bash" }

return opts
