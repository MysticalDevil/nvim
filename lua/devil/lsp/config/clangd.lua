local util = require("devil.lsp.util")

local capabilities = vim.lsp.protocol.make_client_capabilities()
---@diagnostic disable-next-line
capabilities.offsetEncoding = { "utf-16" }

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
      BlockEnd = false,
      Designators = true,
      Enabled = true,
      ParameterNames = true,
      DeducedTypes = true,
      TypeNameLimit = 24,
    },
    CompileFlags = {
      Add = { "-Wall", "" },
      Compiler = "clang++",
    },
  },
}
opts.cmd = {
  "clangd",
  "--pch-storage=memory",
  "--background-index",
  "--clang-tidy",
  "--header-insertion=iwyu",
  "--completion-style=detailed",
  "--function-arg-placeholders",
  "--fallback-style=llvm",
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

  require("lsp_signature").on_attach({
    bind = true,
    handler_opts = {
      border = "rounded",
    },
  }, bufnr)

  vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", { buf = bufnr })
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
  vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", { buf = bufnr })

  util.set_inlay_hints(client, bufnr)
end
opts.single_file_support = true

return opts
