local status, lsp_signature = pcall(require, "lsp_signature")
if not status then
  vim.notify("lsp_signature.nvim not found", "error")
  return
end

local opts = {
  -- bind = true, -- This is mandatory, otherwise border config won't get registered.
  -- handler_opts = {
  --   border = "rounded",
  -- },
}

lsp_signature.setup(opts)
