local common = require("lsp.common-config")
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, bufnr)
    common.disableFormat(client)
    common.keyAttach(bufnr)
  end,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}

return {
  on_setup = function(server)
    local ok_rt, rust_tools = pcall(require, "rust-tools")
    if not ok_rt then
      print("Failed to load rust tools, will set up `rust-analyzer` without `rust-tools`.")
      server.setup(opts)
    else
      rust_tools.setup({
        server = opts,
        dap = require("dap.nvim-dap.config.rust"),
      })
    end
  end,
}
