local modules = {
  require("devil.plugins.specs.foundation"),
  require("devil.plugins.specs.core"),
  require("devil.plugins.specs.treesitter"),
  require("devil.plugins.specs.tools"),
  require("devil.plugins.specs.git"),
  require("devil.plugins.specs.prog"),
}

local specs = {}
for _, module_specs in ipairs(modules) do
  vim.list_extend(specs, module_specs)
end

return specs
