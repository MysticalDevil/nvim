local util = require("lsp.util")

local opts = util.default_configs()

opts.settings = {
  gopls = {
    experimentalPostfixCompletions = true,
    analyses = {
      unusedparams = true,
      shadow = true,
    },
    staticcheck = true,
    gofumpt = true,
  },
}
opts.init_options = {
  usePlaceholders = true,
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
