local util = require("lsp.util")

local opts = util.default_configs()

opts.filetypes = {
  "astro",
  "css",
  "eruby",
  "html",
  "htmldjango",
  "javascriptreact",
  "less",
  "pug",
  "sass",
  "scss",
  "svelte",
  "typescriptreact",
  "vue",
}
opts.single_file_support = true

return util.set_on_setup(opts)
