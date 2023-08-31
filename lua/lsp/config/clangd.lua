local util = require("lsp.util")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }

local opts = util.default_configs

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
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
