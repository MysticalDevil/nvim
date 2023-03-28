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
vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opts_remap = {
  remap = true,
  silent = true,
}

local opts_expr = {
  expr = true,
  silent = true,
}

-- 命令行下 Ctrl+j/k 下/上一个
keymap("c", "<C-j>", "<C-n>", opts_remap)
keymap("c", "<C-k>", "<C-p>", opts_remap)

-- $ 跳到行尾不带空格（交换 $ 和 g_）
keymap({ "n", "v" }, "$", "g_")
keymap({ "n", "v" }, "g_", "$")

-- 上下滚动浏览
keymap({ "n", "v" }, "<C-j>", "5j")
keymap({ "n", "v" }, "<C-k>", "5k")

-- ctrl + u/d 只移动10行，默认移动半屏
keymap({ "n", "v" }, "<C-d>", "10j")
keymap({ "n", "v" }, "<C-u>", "10k")

local enable_magic_search = true

-- magic search
if enable_magic_search then
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
keymap("t", "<ESC>", "<C-\\><C-n>")

-----------------------------------------------------------
-- 插件快捷键
local pluginKeys = {}

-- lsp 回调函数快捷键设置
pluginKeys.mapLSP = function(mapbuf)
  -- rename
  -- Lspsaga 替换 rn
  -- mapbuf("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opt)
  -- mapbuf("n", lsp.rename, "<cmd>lua vim.lsp.buf.rename()<CR>")

  -- code action
  -- Lspsaga 替换 ca
  mapbuf("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opt)
  -- mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")

  -- go xx
  -- mapbuf('n', 'gd', '<cmd>Lspsaga preview_definition<CR>', opt)
  -- mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
  mapbuf("n", "gd", function()
    require("telescope.builtin").lsp_definitions({
      initial_mode = "normal",
      -- ignore_filename = false,
    })
  end)

  -- hover document
  -- Lspsaga 替换 gh
  mapbuf("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opt)
  -- mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>")

  -- Go to references
  -- Lspsaga 替换 gr
  -- mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
  -- mapbuf("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opt)
  mapbuf("n", "gr", function()
    require("telescope.builtin").lsp_references(require("telescope.themes").get_ivy())
  end)

  if vim.fn.has("nvim-0.8") == 1 then
    mapbuf("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>")
  else
    mapbuf("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
  end

  -- diagnostic
  -- Lspsaga 替换 gp, gj, gk
  -- mapbuf("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
  -- mapbuf("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opt)
  -- mapbuf("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opt)
  mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>")
  mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>")
  mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>")

  -- 未用
  -- mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
  -- mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
  -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
  -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end

-- typescript 快捷键
pluginKeys.mapTsLSP = function(bufnr)
  local bufopts = { noremap = true, slient = true, buffer = bufnr }
  keymap("n", "gs", ":TSLspOrganize<CR>", bufopts)
  keymap("n", "gR", ":TSLspRenameFile<CR>", bufopts)
  keymap("n", "gi", ":TSLspImportAll<CR>", bufopts)
end

-- nvim-dap
pluginKeys.mapDAP = function()
  -- start
  map("n", "<leader>dd", ":RustDebuggables<CR>", opt)
  -- end
  map(
    "n",
    "<leader>de",
    ":lua require('dap').close()<CR>"
      .. ":lua require('dap').terminate()<CR>"
      .. ":lua require('dap.repl').close()<CR>"
      .. ":lua require('dapui').close()<CR>"
      .. ":lua require('dap').clear_breakpoints()<CR>"
      .. "<C-w>o<CR>",
    opt
  )
  -- continue
  map("n", "<Leader>dc", ":lua require('dap').continue()<CR>", opt)
  -- set breakpoint
  map("n", "<Leader>dt", ":lua require('dap').toggle_breakpoint()<CR>", opt)
  map("n", "<Leader>dT", ":lua require('dap').clear_breakpoints()<CR>", opt)
  -- stepOver, stepOut, stepInfo
  map("n", "<Leader>dj", ":lua require('dap').steo_over()<CR>", opt)
  map("n", "<Leader>dk", ":lua require('dap').step_out()<CR>", opt)
  map("n", "<Leader>dl", ":lua require('dap').step_into()<CR>", opt)
  -- pop-ups
  map("n", "<Leader>dh", ":lua require('dapui').eval()<CR>", opt)
end

-- gitsigns
pluginKeys.gitsigns_on_attach = function(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map("n", "<leader>gj", function()
    if vim.wo.diff then
      return "]c"
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return "<Ignore>"
  end, {
    expr = true,
  })

  map("n", "<leader>gk", function()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return "<Ignore>"
  end, {
    expr = true,
  })

  map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
  map("n", "<leader>gS", gs.stage_buffer)
  map("n", "<leader>gu", gs.undo_stage_hunk)
  map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
  map("n", "<leader>gR", gs.reset_buffer)
  map("n", "<leader>gp", gs.preview_hunk)
  map("n", "<leader>gb", function()
    gs.blame_line({
      full = true,
    })
  end)
  map("n", "<leader>gd", gs.diffthis)
  map("n", "<leader>gD", function()
    gs.diffthis("~")
  end)
  -- toggle
  map("n", "<leader>gtd", gs.toggle_deleted)
  map("n", "<leader>gtD", gs.toggle_current_line_blame)
  -- Text object
  map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
end

return pluginKeys
