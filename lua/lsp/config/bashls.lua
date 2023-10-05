local util = require("lsp.util")

local opts = util.default_configs()

opts.cmd = { "bash-language-server", "start" }
opts.settings = {
  bashIde = {
    globPattern = "*@(.sh|.inc|.bash|.command)",
  },
}
opts.filetype = { "sh", "zsh", "bash" }
opts.single_file_support = true

return util.set_on_setup(opts)
