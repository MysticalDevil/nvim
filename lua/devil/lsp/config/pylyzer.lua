local util = require("devil.lsp.util")

local opts = util.default_configs()

opts.settings = {
  python = {
    checkOnType = false,
    diagnostics = true,
    inlayHints = true,
    smartCompletion = true,
  },
}
opts.filetypes = { "python" }
opts.single_file_support = true

return util.on_setup(opts)
