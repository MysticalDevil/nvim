local uConfig = require('uConfig')
local uToggleTerm = uConfig.toggleterm

if uToggleTerm == nil or not uToggleTerm.enable then
  return
end

local status, toggleterm = pcall(require, 'toggleterm')
if not status then
  vim.notify('toggleterm not found')
  return
end

local opts = {
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.3
    end
  end,
  start_in_insert = true,
}

toggleterm.setup(opts)

local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({
  cmd = 'lazygit',
  dir = 'git_dir',
  direction = 'float',
  float_opts = {
    border = 'double',
  },
  on_open = function(term)
    vim.cmd('startinsert!')
    -- q / <leader>tg 关闭 terminal
    vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<CMD>close<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(term.bufnr, 'n', '<leader>tg', '<CMD>close<CR>', { noremap = true, silent = true })
    -- ESC 键取消，留给 lazygit
    if vim.fn.mapcheck('<Esc>', 't') ~= '' then
      vim.api.nvim_del_keymap('t', '<Esc>')
    end
  end,
  on_close = function(_)
    -- 添加回来
    vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
  end
})

local ta = Terminal:new({
  direction = 'float',
  close_on_exit = true,
})

local tb = Terminal:new({
  direction = 'vertical',
  close_on_exit = true,
})

local tc = Terminal:new({
  direction = 'horizontal',
  close_on_exit = true,
})

local M = {}

M.toggleA = function(cmd)
  if ta:is_open() then
    ta:close()
    return
  end
  tb:close()
  tc:close()
  ta:open()
  if cmd ~= nil then
    ta:sned(cmd)
  end
end

M.toggleB = function()
  if tb:is_open() then
    tb:close()
    return
  end
  ta:close()
  tc:close()
  tb:open()
end

M.toggleC = function()
  if tc:is_open() then
    tc:close()
    return
  end
  ta:close()
  tb:close()
  tc:open()
end

M.toggleG = function()
  lazygit:toggle()
end

keymap({ 'n', 't' }, uToggleTerm.toggle_window_A, M.toggleA)
keymap({ 'n', 't' }, uToggleTerm.toggle_window_B, M.toggleB)
keymap({ 'n', 't' }, uToggleTerm.toggle_window_C, M.toggleC)
