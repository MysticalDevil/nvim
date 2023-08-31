local util = require("lsp.util")

local opts = util.default_configs

opts.filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" }

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
