local status, coq = pcall(require, "coq")
if not status then
  vim.notify("coq_nvim not found", "error")
  return
end

local lspconfig = require("lspconfig")

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Let coq_nvim additional on attached LSP",
  callback = function(args)
    local client_list = vim.lsp.get_active_clients()
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local client_name = client.name
    local client_id = client.id
    if client_name ~= "null-ls" and client_id <= #client_list then
      vim.notify(client_id .. ": " .. client_name)
      lspconfig[client_name].setup(coq.lsp_ensure_capabilities())
    end
  end,
})
