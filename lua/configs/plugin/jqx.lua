local status, jqx = pcall(require, "nvim-jqx")
if not status then
  vim.notify("nvim-jqx not found", "error")
  return
end

jqx.geometry.border = "single"
jqx.geometry.width = 0.7
jqx.query_key = "X" -- keypress to query jq on keys
jqx.sort = false -- show the json keys as they appear instead of sorting them alphabetically
jqx.show_legend = true -- show key queried as first line in the jqx floating window
jqx.use_quickfix = false -- if you prefer the location list

local jqx_group = vim.api.nvim_create_augroup("Jqx", {})
vim.api.nvim_clear_autocmds({ group = jqx })
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.json", "*.yaml" },
  desc = "preview json and yaml files on open",
  group = jqx_group,
  callback = function()
    vim.cmd.JqxList()
  end,
})
