local status, yanky = pcall(require, "yanky")
if not status then
  vim.notify("yanky.nvim not found", "error")
  return
end

local opts = {
  ring = {
    history_length = 100,
    storage = "shada",
    storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
    sync_with_numbered_registers = true,
    cancel_event = "update",
    ignore_registers = { "_" },
    update_register_on_cycle = false, -- EXPERIMENTAL
  },
  picker = {
    select = {
      action = nil, -- nil to use default put action
    },
    telescope = {
      use_default_mappings = true, -- if default mappings should be used
      mappings = nil, -- nil to use default mappings or no mappings (see `use_default_mappings`)
    },
  },
  system_clipboard = {
    sync_with_ring = true,
  },
  highlight = {
    on_put = true,
    on_yank = true,
    timer = 500,
  },
  preserve_cursor_position = {
    enabled = true,
  },
  textobj = {
    enabled = false,
  },
}

vim.keymap.set("n", "<leader>p", function()
  require("telescope").extensions.yank_history.yank_history({})
end, { desc = "Open Yank History" })
vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)", { desc = "Yank text" })
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Put yanked text after cursor" })
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Put yanked text before cursor" })
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { desc = "Put yanked text after selection" })
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { desc = "Put yanked text before selection" })
vim.keymap.set("n", "[y", "<Plug>(YankyCycleForward)", { desc = "Cycle forward through yank history" })
vim.keymap.set("n", "]y", "<Plug>(YankyCycleBackward)", { desc = "Cycle backward through yank history" })
vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)", { desc = "Put indented after cursor (linewise)" })
vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)", { desc = "Put indented before cursor (linewise)" })
vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)", { desc = "Put indented after cursor (linewise)" })
vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)", { desc = "Put indented before cursor (linewise)" })
vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)", { desc = "Put and indent right" })
vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", { desc = "Put and indent left" })
vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", { desc = "Put before and indent right" })
vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", { desc = "Put before and indent left" })
vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)", { desc = "Put after applying a filter" })
vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)", { desc = "Put before applying a filter" })

yanky.setup(opts)
