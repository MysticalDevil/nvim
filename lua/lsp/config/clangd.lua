local util = require("lsp.util")

local capabilities = vim.lsp.protocol.make_client_capabilities()
---@diagnostic disable-next-line
capabilities.offsetEncoding = { "utf-16" }

local inlay_hints = require("clangd_extensions.inlay_hints")

local opts = util.default_configs()

opts.capabilities = capabilities
opts.filetypes = {
  "c",
  "cpp",
  "h",
  "hpp",
  "cuda",
  "objcpp",
  "cppm",
}
opts.settings = {
  clangd = {
    InlayHints = {
      Designators = true,
      Enabled = true,
      ParameterNames = true,
      DeducedTypes = true,
    },
    fallbackFlags = { "-std=c++20" },
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
opts.root_dir = function(fname)
  return require("lspconfig.util").root_pattern(
    "configure.ac",
    "Makefile",
    "configure.in",
    "config.h.in",
    "meson.build",
    "meson_options.txt",
    "build.ninja"
  )(fname) or require("lspconfig.util").root_pattern(
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt"
  )(fname) or require("lspconfig.util").find_git_ancestor(fname)
end

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
opts.single_file_support = true

return util.set_on_setup(opts)
