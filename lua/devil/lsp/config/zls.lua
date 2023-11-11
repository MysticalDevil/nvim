local util = require("devil.lsp.util")
local opts = util.default_configs()

opts.filetypes = { "zig", "zir" }
opts.single_file_support = true
opts.settings = {
  zls = {
    enable_inlay_hints = true,
    inlay_hints_show_builtin = true,
    inlay_hints_exclude_single_argument = true,
    inlay_hints_hide_redundant_param_names = false,
    inlay_hints_hide_redundant_param_names_last_token = false,
  },
}
opts.root_dir = function(fname)
  return require("lspconfig.util").root_pattern("zls.json")(fname) or require("lspconfig.util").find_git_ancestor(fname)
end

opts.single_file_support = true

return util.set_on_setup(opts)