local status, ssr = pcall(require, "ssr")
if not status then
  vim.notify("ssr.nvim not found", "error")
  return
end

local opts = {
  min_width = 50,
  min_height = 5,
  max_width = 120,
  max_height = 25,
  keymaps = {
    close = "q",
    next_match = "n",
    prev_match = "N",
    replace_confirm = "<cr>",
    replace_all = "<leader><cr>",
  },
}

ssr.setup(opts)

vim.keymap.set({ "n", "x" }, "<leader>sr", function()
  ssr.open()
end)
