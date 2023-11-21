local status, neogen = pcall(require, "neogen")
if not status then
  vim.notify("neogen not found", "error")
  return
end

local opts = {
  enabled = true, --if you want to disable Neogen
  input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
  snippet_engine = "luasnip",
}

neogen.setup(opts)

vim.keymap.set("n", "<Leader>nf", function()
  neogen.generate({ type = "any" })
end, { noremap = true, silent = true, desc = "Use neogeo to generate" })
