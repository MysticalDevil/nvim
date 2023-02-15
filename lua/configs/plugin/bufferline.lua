local status, bufferline = pcall(require, "bufferline")
if not status then
  vim.notify("bufferline not found", "error")
  return
end

-- bufferline configure
-- https://github.com/akinsho/bufferline.nvim#configuration
local opts = {
  options = {
    -- 关闭 Tab 的命令，这里使用 moll/vim-bbye 的 :Bdelete 命令
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %d",
    -- 侧边栏配置
    -- 左侧让出 nvim-terr 的位置，显示文字 File Explorer
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_algin = "left",
      },
    },
    -- 使用 nvim 内置 LSP
    diagnostics = "nvim_LSP",
    -- 可选，显示 LSP 报错图标
    ---@diagnostic disable-next-line: unused-local
    diagnostics_indicator = function(count, level, diagnotics_dict, contect)
      local s = ""
      for e, n in pairs(diagnotics_dict) do
        local sym = e == "error" and "" or (e == "warning" and "" or "")
        s = s .. n .. sym
      end
      return s
    end,
  },
}
bufferline.setup(opts)

-- 左右 Tab 切换
keymap("n", "<C-h>", ":BufferLineCyclePrev<CR>")
keymap("n", "<C-l>", ":BufferLineCycleNext<CR>")
-- 'moll/vim-bbye' 关闭当前 buffer
keymap("n", "<C-w>", ":Bdelete!<CR>")
-- 关闭左/右侧标签页
keymap("n", "<leader>bh", ":BufferLineCloseLeft<CR>")
keymap("n", "<leader>bl", ":BufferLineCloseRight<CR>")
-- 关闭其他标签页
keymap("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>")
-- 关闭选中标签页
keymap("n", "<leader>bp", ":BufferLinePickClose<CR>")
