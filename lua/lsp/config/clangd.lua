local common = require("lsp.common-config")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
local opts = {
  capabilities = capabilities,
  flags = common.flags,
  cmd = {
    "clangd",
    "--background-index",
    "--pch-storage=memory",
    "--clang-tidy",
    "--completion-style=detailed",
  },
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
  on_attach = function(client, bufnr)
    common.disableFormat(client)
    common.keyAttach(bufnr)
    require("lsp_signature").on_attach({
      bind = true,
      handler_opts = {
        border = "rounded",
      },
    }, bufnr)
    require("nvim-navic").attach(client, bufnr)
  end,
  -- require("coq").lsp_ensure_capabilities(),
  settings = {
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
  },
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
