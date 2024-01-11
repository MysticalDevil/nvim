require("devil.dap.ui")

require("nvim-dap-virtual-text").setup({
  commented = true,
})

require("devil.dap.config.lua").setup()
require("devil.dap.config.cxx").setup()
require("dap-go").setup(require("devil.dap.config.go"))
