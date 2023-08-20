-- Modes
-- normal_mode = 'n',
-- insert_mode = 'i',
-- visual_mode = 'v',
-- visual_block_mode = 'x',
-- term_mode = 't',
-- command_mode = 'c',

local map = vim.api.nvim_set_keymap
local opt = {
  noremap = true,
  silent = true,
}
-----------------------------------------------------------

-- leader key is null
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

-- under the command line, Ctrl+j/k is the next/previous
keymap("c", "<C-j>", "<C-n>", opts_remap)
keymap("c", "<C-k>", "<C-p>", opts_remap)

keymap({ "n", "v" }, "$", "g_")
keymap({ "n", "v" }, "g_", "$")

-- scroll up and down
keymap({ "n", "v" }, "<C-j>", "5j")
keymap({ "n", "v" }, "<C-k>", "5k")

-- ctrl + u/d move 10 lines, half screen by default
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

-- indent code in visual mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- move selected text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv")
keymap("x", "K", ":move '<-2<CR>gv-gv")

-- paste but do not copy in visual mode
keymap("x", "p", "_dP")

-- type `esc` to back normal mode
keymap("t", "<ESC>", "<C-\\><C-n>")

-----------------------------------------------------------
local pluginKeys = {}

-- LSP callback function shortcut key setting
pluginKeys.mapLSP = function(mapbuf)
  -- rename
  -- Lspsaga replace rn
  -- mapbuf("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opt)
  -- mapbuf("n", lsp.rename, "<cmd>lua vim.lsp.buf.rename()<CR>")

  -- code action
  -- Lspsaga replace ca
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
  -- Lspsaga replace gh
  mapbuf("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opt)
  -- mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>")

  -- Go to references
  -- Lspsaga replace gr
  -- mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
  -- mapbuf("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opt)
  mapbuf("n", "gr", function()
    require("telescope.builtin").lsp_references(require("telescope.themes").get_ivy())
  end)

  -- diagnostic
  -- Lspsaga replace gp, gj, gk
  -- mapbuf("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
  -- mapbuf("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opt)
  -- mapbuf("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opt)
  mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>")
  mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>")
  mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>")

  -- unused
  -- mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
  -- mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
  -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
  -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
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
