local status, bufferline = pcall(require, "bufferline")
if not status then
  vim.notify("bufferline.nvim not found", "error")
  return
end

-- bufferline configure
-- https://github.com/akinsho/bufferline.nvim#configuration
local opts = {
  options = {
    -- The command to close tab. The `Bdelete` command of mall/vim-bbye is used here.
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %d",
    -- sidebar configuration
    -- give up the position of neo-tree on the left, show File Explorer
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        text_algin = "left",
      },
    },
    -- use neovim built-in LSP
    diagnostics = "nvim_lsp",
    -- optional, show LSP diagnostic icon
    ---@diagnostic disable-next-line: unused-local
    -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
    diagnostics_indicator = function(_, _, diagnostics_dict, _)
      local s = ""
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and "" or (e == "warning" and "" or "")
        s = s .. n .. sym
      end
      return s
    end,
  },
}
bufferline.setup(opts)

-- left and right tab switching
keymap("n", "<C-h>", ":BufferLineCyclePrev<CR>")
keymap("n", "<C-l>", ":BufferLineCycleNext<CR>")
-- close current buffer
keymap("n", "<C-w>", ":Bdelete!<CR>")
-- close left/right tab
keymap("n", "<leader>bh", ":BufferLineCloseLeft<CR>")
keymap("n", "<leader>bl", ":BufferLineCloseRight<CR>")
-- close other tab
keymap("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>")
-- close picked tab
keymap("n", "<leader>bp", ":BufferLinePickClose<CR>")
