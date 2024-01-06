local utils = require("devil.utils")

vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opts = { enable_magic_search = true, enable_space_visible = false }

-- magic search
if opts.enable_magic_search then
  utils.keymap({ "n", "v" }, "/", "/\\v", {
    remap = false,
    silent = false,
  })
else
  utils.keymap({ "n", "v" }, "/", "/", {
    remap = false,
    silent = false,
  })
end

local M = {}

M.general = {
  i = {
    ["<C-b>"] = { "<ESC>^i", "Begging of line" },
    ["<C-e>"] = { "<End>", "End of line" },

    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
  },

  n = {
    ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlight" },
    ["<C-j>"] = { "5j", "Five lines down" },
    ["<C-k>"] = { "5k", "Five lines up" },
    ["<C-d>"] = { "10j", "Five lines down" },
    ["<C-u>"] = { "10k", "Five lines up" },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

    -- new buffer
    ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },

    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },

    ["<leader>f"] = {
      function()
        vim.lsp.buf.format({ async = true })
      end,
      "LSP formatting",
    },

    ["<Space>t"] = {
      function()
        if opts.space_visible then
          vim.opt.listchars:remove("space:·")
        else
          vim.opt.listchars:append("space: ")
        end

        opts.space_visible = not opts.space_visible
      end,
      "Toggle space visible status",
    },

    ["<leader>q"] = { ":q<CR>", "Quit editor" },
    ["<leader>w"] = { ":w<CR>", "Save file" },
    ["<leader>z"] = { "<cmd>ZenMode<CR>", "Enter zen mode" },
    ["<leader>o"] = { "<cmd>SymbolsOutline<CR>", "Toggle symbols outline tree" },

    -- s_windows
    ["sv"] = { ":vsp<CR>", "Split window vertically" },
    ["sh"] = { ":sp<CR>", "Split window horizontally" },
    ["sc"] = { "<C-w>c", "Close picked split window" },
    ["so"] = { "<C-w>o", "Close other split window" },
    ["s,"] = { ":vertical resize -10<CR>", "Reduce vertical window size" },
    ["s."] = { ":vertical resize +10<CR>", "Increase vertical window size" },
    ["sj"] = { ":horizontal resize -5<CR>", "Reduce horizontal window size" },
    ["sk"] = { ":horizontal resize +5<CR>", "Increase vertical window size" },
    ["s="] = { "<C-w>=", "Make split windows equal in size" },

    -- tabs
    ["ts"] = { "<cmd>tab split<CR>", "Split window use tab" },
    ["th"] = { "<cmd>tabprev<CR>", "Switch to previous tab" },
    ["tj"] = { "<cmd>tabnext<CR>", "Switch to next tab" },
    ["tf"] = { "<cmd>tabfirst<CR>", "Switch to first tab" },
    ["tl"] = { "<cmd>tablast<CR>", "Switch to last tab" },
    ["tc"] = { "<cmd>tabclose<CR>", "Close tab" },

    ["zo"] = { "<CMD>foldopen<CR>", "Open fold" },
    ["zc"] = { "<CMD>foldclose<CR>", "Close fold" },
  },

  v = {
    ["<C-j>"] = { "5j", "Five lines down" },
    ["<C-k>"] = { "5k", "Five lines up" },
    ["<C-d>"] = { "10j", "Five lines down" },
    ["<C-u>"] = { "10k", "Five lines up" },

    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["<"] = { "<gv", "Indent line" },
    [">"] = { ">gv", "Indent line" },
  },

  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
  },

  c = {
    ["<C-j>"] = { "<C-n>", "Next line" },
    ["<C-k>"] = { "<C-p>", "Previous line" },
  },

  t = {
    ["<ESC>"] = { "<C-\\><C-n>", "Back to normal mode" },
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.lspconfig = {
  plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<leader>ra"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["gr"] = {
      function()
        -- vim.lsp.buf.references()
        require("telescope.builtin").lsp_references(require("telescope.themes").get_ivy())
      end,
      "LSP references",
    },

    ["<leader>lf"] = {
      function()
        vim.diagnostic.open_float({ border = "rounded" })
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev({ float = { border = "rounded" } })
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next({ float = { border = "rounded" } })
      end,
      "Goto next",
    },

    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Diagnostic setloclist",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },

    ["<leader>L"] = {
      function()
        if vim.lsp.inlay_hint.is_enabled() then
          vim.lsp.inlay_hint.enable(nil, false)
        else
          vim.lsp.inlay_hint.enable(nil, true)
        end
      end,
      "Toggle LSP inlay hints",
    },
  },

  v = {
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },

    -- Actions
    ["<leader>rh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    ["<leader>ph"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },

    ["<leader>gb"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },

    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },
}

M.bufferline = {
  plugin = true,

  n = {
    ["<C-h>"] = { "<CMD>BufferLineCyclePrev<CR>", "Cycle previous buffer" },
    ["<C-l>"] = { "<CMD>BufferLineCycleNext<CR>", "Cycle next buffer" },
    ["<C-w>"] = { "<CMD>Bdelete!<CR>", "Delete buffer" },
    ["<A-<>"] = { "<CMD>BufferLineMovePrev<CR>", "Move buffer to previous" },
    ["<A->>"] = { "<CMD>BufferLineMoveNext<CR>", "Move buffer to next" },
    ["<A-1>"] = { "<CMD>BufferLineGoToBuffer 1<CR>", "Go to 1 buffer" },
    ["<A-2>"] = { "<CMD>BufferLineGoToBuffer 2<CR>", "Go to 2 buffer" },
    ["<A-3>"] = { "<CMD>BufferLineGoToBuffer 3<CR>", "Go to 3 buffer" },
    ["<A-4>"] = { "<CMD>BufferLineGoToBuffer 4<CR>", "Go to 4 buffer" },
    ["<A-5>"] = { "<CMD>BufferLineGoToBuffer 5<CR>", "Go to 5 buffer" },
    ["<A-6>"] = { "<CMD>BufferLineGoToBuffer 6<CR>", "Go to 6 buffer" },
    ["<A-7>"] = { "<CMD>BufferLineGoToBuffer 7<CR>", "Go to 7 buffer" },
    ["<A-8>"] = { "<CMD>BufferLineGoToBuffer 8<CR>", "Go to 8 buffer" },
    ["<A-9>"] = { "<CMD>BufferLineGoToBuffer 9<CR>", "Go to 9 buffer" },
    ["<A-0>"] = { "<CMD>BufferLineGoToBuffer -1<CR>", "Go to first buffer" },
    ["<A-p>"] = { "<CMD>BufferLineTogglePin<CR>", "Toggle pinned buffer" },
    ["<Space>bt"] = { "<Cmd>BufferLineSortByTabs<CR>", "Sory buffers by tabs" },
    ["<Space>bd"] = { "<Cmd>BufferLineSortByDirectory<CR>", "Sort buffers by directories" },
    ["<Space>be"] = { "<Cmd>BufferLineSortByExtension<CR>", "Sort buffers by extensions" },
    ["<leader>bh"] = { "<CMD>BufferLineCloseLeft<CR>", "Close left buffer" },
    ["<leader>bl"] = { "<CMD>BufferLineCloseRight<CR>", "Close right buffer" },
    ["<leader>bp"] = { "<CMD>BufferLinePick<CR>", "Pick buffer" },
    ["<leader>bo"] = { "<CMD>BufferLineCloseRight<CR><CMD>BufferLineCloseLeft<CR>", "Close other buffer" },
    ["<leader>bc"] = { "<CMD>BufferLinePickClose<CR>", "Close picked buffer" },
  },
}

M.neo_tree = {
  plugin = true,

  n = {},
}

M.telescope = {
  plugin = true,

  n = {
    ["<C-p>"] = {
      function()
        require("telescope").extensions.smart_open.smart_open()
      end,
      "Find files",
    },

    -- find
    -- ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>ff"] = {
      function()
        require("telescope").extensions.smart_open.smart_open()
      end,
      "Find files",
    },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
    ["<leader>fp"] = { "<cmd> Telescope project <CR>", "Find recently projects" },
  },
}

M.hlslens = {
  plugin = true,

  n = {
    ["n"] = {
      "<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>",
      "",
      opts = { noremap = true, silent = true },
    },
    ["N"] = {
      "<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require('hlslens').start()<CR>",
      "",

      opts = { noremap = true, silent = true },
    },

    ["*"] = {
      "*<cmd>lua require('hlslens').start()<CR>",
      "",
      opts = { noremap = true, silent = true },
    },
    ["#"] = {
      "#<cmd>lua require('hlslens').start()<CR>",
      "",
      opts = { noremap = true, silent = true },
    },
    ["g*"] = {
      "g*<cmd>lua require('hlslens').start()<CR>",
      "",
      opts = { noremap = true, silent = true },
    },
    ["g#"] = {
      "g#<cmd>lua require('hlslens').start()<CR>",
      "",
      opts = { noremap = true, silent = true },
    },
  },
}

M.trouble = {
  plugin = true,
  n = {
    ["<leader>xx"] = { "<cmd>TroubleToggle<cr>", "Toggle trouble panel" },
    ["<leader>xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Toggle workspace diagnostics" },
    ["<leader>xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Toggle document diagnostics" },
    ["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", "Toggle quick fix" },
    ["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", "Toggle loc list" },
    ["<leader>xr"] = { "<cmd>TroubleToggle lsp_references<cr>", "Toggle LSP references" },
  },
}

M.whichkey = {
  plugin = true,

  n = {
    ["<leader>wK"] = {
      function()
        vim.cmd("WhichKey")
      end,
      "Which-key all keymaps",
    },
    ["<leader>wk"] = {
      function()
        local input = vim.fn.input("WhichKey: ")
        vim.cmd("WhichKey " .. input)
      end,
      "Which-key query lookup",
    },
  },
}

M.yanky = {
  plugin = true,

  n = {
    ["y"] = {
      "<Plug>(YankyYank)",
      "Yank text",
    },
    ["p"] = {
      "<Plug>(YankyPutAfter)",
      "Put yanked text after cursor",
    },
    ["P"] = {
      "<Plug>(YankyPutBefore)",
      "Put yanked text before cursor",
    },
    ["gp"] = {
      "<Plug>(YankyGPutAfter)",
      "Put yankyed text after selection",
    },
    ["gP"] = {
      "<Plug>(YankyGPutBefore)",
      "Put yankyed text before selection",
    },
    ["]y"] = {
      "<Plug>(YankyCycleForward)",
      "Cycle forward through yank history",
    },
    ["[y"] = {
      "<Plug>(YankyCycleBackward)",
      "Cycle backward through yank history",
    },
    ["]p"] = {
      "<Plug>(YankyPutIndentAfterLinewise)",
      "Put indented after cursor (linewise)",
    },
    ["[p"] = {
      "<Plug>(YankyPutIndentBeforeLinewise)",
      "Put indented before cursor (linewise)",
    },
    ["]P"] = {
      "<Plug>(YankyPutIndentAfterLinewise)",
      "Put indented after cursor (linewise)",
    },
    ["[P"] = {
      "<Plug>(YankyPutIndentBeforeLinewise)",
      "Put indented before cursor (linewise)",
    },
    [">p"] = {
      "<Plug>(YankyPutIndentAfterShiftRight)",
      "Put and indent right",
    },
    ["<p"] = {
      "<Plug>(YankyPutIndentAfterShiftLeft)",
      "Put and indent left",
    },
    [">P"] = {
      "<Plug>(YankyPutIndentBeforeShiftRight)",
      "Put before and indent right",
    },
    ["<P"] = {
      "<Plug>(YankyPutIndentBeforeShiftLeft)",
      "Put before and indent left",
    },
    ["=p"] = {
      "<Plug>(YankyPutAfterFilter)",
      "Put after applying a filter",
    },
    ["=P"] = {
      "<Plug>(YankyPutBeforeFilter)",
      "Put before applying a filter",
    },
    ["<leader>yp"] = {
      function()
        require("telescope").extensions.yank_history.yank_history({})
      end,
      "Open Yank History",
    },
  },

  x = {
    ["y"] = {
      "<Plug>(YankyYank)",
      "Yank text",
    },
    ["p"] = {
      "<Plug>(YankyPutAfter)",
      "Put yanked text after cursor",
    },
    ["P"] = {
      "<Plug>(YankyPutBefore)",
      "Put yanked text before cursor",
    },
    ["gp"] = {
      "<Plug>(YankyGPutAfter)",
      "Put yankyed text after selection",
    },
    ["gP"] = {
      "<Plug>(YankyGPutBefore)",
      "Put yankyed text before selection",
    },
  },
}

M.dap = {
  plugin = true,

  n = {
    -- debug
    ["de"] = {
      function()
        local dap = require("dap")
        local dap_ui = require("dapui")
        dap.close()
        dap.terminate()
        dap.repl.close()
        dap_ui.close()
        dap.clear_breakpoints()
      end,
      "End debugger",
    },
    ["dc"] = {
      function()
        require("dap").continue()
      end,
      "Continue debug",
    },
    ["dt"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "Set breakpoint",
    },
    ["dT"] = {
      function()
        require("dap").clear_breakpoints()
      end,
      "Clear breakpoint",
    },
    ["dj"] = {
      function()
        require("dap").step_over()
      end,
      "Step over",
    },
    ["dk"] = {
      function()
        require("dap").step_out()
      end,
      "Step out",
    },
    ["dl"] = {
      function()
        require("dap").step_into()
      end,
      "Step into",
    },
    ["dh"] = {
      function()
        require("dapui").eval()
      end,
      "Popups dapUI eval",
    },
  },
}

M.ufo = {
  plugin = true,
  n = {
    ["zR"] = {
      function()
        ufo.openAllFolds()
      end,
      "Open all folds",
    },
    ["zM"] = {
      function()
        ufo.closeAllFolds()
      end,
      "Close all folds",
    },
    ["zr"] = {
      function()
        ufo.openFoldsExceptKinds()
      end,
      "Open all folds except kinds",
    },
    ["zm"] = {
      function()
        ufo.closeFoldsWith()
      end,
      "Close fold with",
    },
    ["zK"] = {
      function()
        local winid = ufo.peekFoldedLinesUnderCursor()
        if not winid then
          -- choose one of coc.nvim and nvim lsp
          vim.fn.CocActionAsync("definitionHover") -- coc.nvim
          vim.lsp.buf.hover()
        end
      end,
      "Peek folded lines under cursor",
    },
  },
}

return M
