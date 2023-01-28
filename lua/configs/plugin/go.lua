local status, go = pcall(require, "go")
if not status then
  vim.notify("Go.nvim not found", "error")
  return
end

local opts = {}

-- Run gofmt + goimport on save
local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require("go.format").goimport()
  end,
  group = format_sync_grp,
})

go.setup(opts)
