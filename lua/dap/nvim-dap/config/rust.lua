local extension_path = string.format("%s/mason/packages/codelldb", vim.fn.stdpath("data"))
local codelldb_path = string.format("%s/codelldb", extension_path)
local liblldb_path = string.format("%s/extension/lldb/lib/liblldb.so", extension_path)

print(codelldb_path)
print(liblldb_path)

return {
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  },
}
