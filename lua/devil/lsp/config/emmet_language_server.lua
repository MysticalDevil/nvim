local util = require("devil.lsp.util")
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

return opts
