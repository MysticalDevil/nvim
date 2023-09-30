local util = require("lsp.util")
local opts = util.default_configs()

opts.filetypes = { "vim" }
opts.init_options = {
  diagnostic = {
    enable = true,
  },
  indexes = {
    count = 3,
    gap = 100,
    projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
    runtimepath = true,
  },
  isNeovim = true,
  iskeyword = "@,48-57,_,192-255,-#",
  runtimepath = "",
  suggest = {
    fromRuntimepath = true,
    fromVimruntime = true,
  },
  vimruntime = "",
}
opts.single_file_support = true

return util.on_setup(opts, require("complete.setup").engine)
