vim.treesitter.language.register("bash", "ebuild")

vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2

vim.wo.wrap = false
vim.wo.signcolumn = "yes"

local phases = [[^\s*\(pkg_.*\|src_.*\)\s*()]]
vim.keymap.set("n", "]p", function()
  vim.fn.search(phases)
end, { buffer = true })
vim.keymap.set("n", "[p", function()
  vim.fn.search(phases, "b")
end, { buffer = true })

local cmds = require("devil.utils.ebuild_cmds")

vim.api.nvim_buf_create_user_command(0, "PkgManifest", function()
  cmds.pkg_manifest()
end, { desc = "Run pkgdev manifest in current ebuild dir and open quickfix" })

vim.api.nvim_buf_create_user_command(0, "PkgCheck", function()
  cmds.pkg_check()
end, { desc = "Run pkgcheck scan in current ebuild dir and open quickfix" })
