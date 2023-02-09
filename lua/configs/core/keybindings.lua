local uConfig = require("configs.core.uConfig")
local keys = uConfig.keys

-- Modes
-- normal_mode = 'n',
-- insert_mode = 'i',
-- visual_mode = 'v',
-- visual_block_mode = 'x',
-- term_mode = 't',
-- command_mode = 'c',

-- 本地变量，用于简化键位映射
local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = {
  noremap = true,
  silent = true,
}
-----------------------------------------------------------

-- leader key 为空
vim.g.mapleader = keys.leader_key
vim.g.maplocalleader = keys.leader_key

local opts_remap = {
  remap = true,
  silent = true,
}

local opts_expr = {
  expr = true,
  silent = true,
}

-- 命令行下 Ctrl+j/k 下/上一个
keymap("c", keys.c_next_item, "<C-n>", opts_remap)
keymap("c", keys.c_prev_item, "<C-p>", opts_remap)

-- $ 跳到行尾不带空格（交换 $ 和 g_）
keymap({ "n", "v" }, "$", "g_")
keymap({ "n", "v" }, "g_", "$")

-- 上下滚动浏览
keymap({ "n", "v" }, keys.n_v_5j, "5j")
keymap({ "n", "v" }, keys.n_v_5k, "5k")

-- ctrl + u/d 只移动10行，默认移动半屏
keymap({ "n", "v" }, keys.n_v_10j, "10j")
keymap({ "n", "v" }, keys.n_v_10k, "10k")

-- magic search
if uConfig.enable_magic_search then
  keymap({ "n", "v" }, "/", "/\\v", {
    remap = false,
    silent = false,
  })
else
  keymap({ "n", "v" }, "/", "/", {
    remap = false,
    silent = false,
  })
end

---------------------------- fix --------------------------

-- fix :set wrap
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", opts_expr)
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", opts_expr)

-- visual 模式下缩进代码
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- 上下移动选中文本
keymap("x", "J", ":move '>+1<CR>gv-gv")
keymap("x", "K", ":move '<-2<CR>gv-gv")

-- 在 visual mode 里粘贴不要复制
keymap("x", "p", "_dP")

-- Esc 回 Normal 模式
keymap("t", keys.terminal_to_normal, "<C-\\><C-n>")
