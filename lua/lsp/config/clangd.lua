local util = require("lsp.util")

local capabilities = vim.lsp.protocol.make_client_capabilities()

local inlay_hints = require("clangd_extensions.inlay_hints")

local opts = util.default_configs()

opts.capabilities = capabilities
opts.settings = {
  filetypes = {
    "c",
    "cpp",
    "h",
    "hpp",
    "cuda",
    "objcpp",
    "proto",
    "cppm",
  },
  clangd = {
    InlayHints = {
      Designators = true,
      Enabled = true,
      ParameterNames = true,
      DeducedTypes = true,
    },
  },
}
opts.cmd = {
  "clangd",
  "--background-index",
  "--pch-storage=memory",
  "--clang-tidy",
  "--completion-style=detailed",
}
opts.init_options = {
  clangdFileStatus = true,
  usePlaceholders = true,
  completeUnimported = true,
  semanticHighlighting = true,
}
opts.on_attach = function(client, bufnr)
  util.disable_format(client)
  util.key_attach(bufnr)

  vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()")
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc")

  if vim.fn.has("nvim-0.10") == 1 then
    util.set_inlay_hints(client, bufnr)
  else
    inlay_hints.setup_autocmd()
    inlay_hints.set_inlay_hints()
  end
end

return util.set_on_setup(opts)
