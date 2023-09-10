local status, _ = pcall(require, "nvim-jqx")
if not status then
  vim.notify("nvim-jqx not found", "error")
  return
end

local jqx = vim.api.nvim_create_augroup("Jqx", {})
vim.api.nvim_clear_autocmds({ group = jqx })
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.json", "*.yaml" },
  desc = "preview json and yaml files on open",
  group = jqx,
  callback = function()
    vim.cmd.JqxList()
  end,
})
