local util = require("lsp.util")

local opts = util.default_configs()

opts.settings = {
  cmd = { "bash-language-server", "start" },
  cmd_env = {
    GLOB_PATTERN = "*@(.sh|.inc|.bash|.command|.zsh)",
  },
  filetype = {
    "sh",
    "zsh",
    "bash",
  },
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
