local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb"
local codelldb_path = extension_path .. "codelldb"
local liblldb_path = extension_path .. "extension/lldb/lib/liblldb.so"

return {
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  },
}
