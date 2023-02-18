local common = require("lsp.common-config")
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, bufnr)
    client.offset_encoding = "utf-16"
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
