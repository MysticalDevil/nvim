-- ~/.config/nvim/after/ftplugin/haskell.lua
local status, haskell_tools = pcall(require, "haskell-tools")
if not status then
  vim.notify("haskell-tools.nvim not found", "error")
  return
end

local bufnr = vim.api.nvim_get_current_buf()
local def_opts = { noremap = true, silent = true, buffer = bufnr }
-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
vim.keymap.set("n", "<space>ca", vim.lsp.codelens.run, def_opts)
-- Hoogle search for the type signature of the definition under the cursor
vim.keymap.set("n", "<space>hs", haskell_tools.hoogle.hoogle_signature, def_opts)
-- Evaluate all code snippets
vim.keymap.set("n", "<space>ea", haskell_tools.lsp.buf_eval_all, def_opts)
-- Toggle a GHCi repl for the current package
vim.keymap.set("n", "<leader>rr", haskell_tools.repl.toggle, def_opts)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set("n", "<leader>rf", function()
  haskell_tools.repl.toggle(vim.api.nvim_buf_get_name(0))
end, def_opts)
vim.keymap.set("n", "<leader>rq", haskell_tools.repl.quit, def_opts)

-- Detect nvim-dap launch configurations
-- (requires nvim-dap and haskell-debug-adapter)
haskell_tools.dap.discover_configurations(bufnr)

vim.g.haskell_tools = {
  hls = {
    filetypes = {
      { "haskell", "lhaskell", "cabal", "cabalproject" },
    },
  },
}
