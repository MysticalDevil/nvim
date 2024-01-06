which_key.register({
  ["<A-t>"] = { "<CMD>Lspsaga term_toggle<CR>", desc = "Float term" },
  ["<leader>q"] = { "<CMD>q<CR>", "Quit editor" },
  ["<leader>f"] = {
    function()
      vim.lsp.buf.format({ async = true })
    end,
    "Format file",
  },
  ["<leader>e"] = { "<cmd>AerialToggle!<CR>", "Aerial Symbol Outline" },
  -- <cmd>Lspsaga code_action<CR>
  ["<leader>ca"] = {
    require("actions-preview").code_actions,
    "Code action",
  },
  ["<leader>vs"] = { "<CMD>VenvSelect<CR>", "Select virtual envs" },
  ["<leader>vc"] = { "<CMD>VenvSelectCached<CR>", "Select cached virtual envs" },
  -- <cmd>Lspsaga rename<CR>
  -- ["<leader>rn"] = { "<cmd>Lspsaga rename<CR>", "Rename" },
  ["<leader>k"] = {
    function()
      vim.lsp.buf.signature_help()
    end,
    "Toggle signature help",
  },
  ["<leader>w"] = { ":w<CR>", "Save file" },
  ["<leader>z"] = { "<CMD>ZenMode<CR>", "Enter zen mode" },
  ["<leader>"] = {
    w = {
      name = "+save",
      a = { "<CMD>wa<CR>", "Save all file" },
      q = { "<CMD>wq<CR>", "Save file and quit editor" },
    },
    q = {
      name = "+quit",
      q = { ":qa!<CR>", "Force quit" },
      a = { ":wqa<CR>", "Save all file and quit editor" },
    },
    b = {
      name = "+bufferline",
      h = { "<CMD>BufferLineCloseLeft<CR>", "Close left bufferline" },
      l = { "<CMD>BufferLineCloseRight<CR>", "Close right bufferline" },
      o = { "<CMD>BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>", "Close other bufferlines" },
      p = { "<CMD>BufferLinePick<CR>", "Pick bufferline" },
      c = { "<CMD>BufferLinePickClose<CR>", "Close picked bufferline" },
    },
    x = {
      name = "+trouble",
      x = { "<CMD>TroubleToggle<CR>", "Open trouble toggle panel" },
      w = { "<CMD>TroubleToggle workspace_diagnostics<CR>", "Open workspace diagnostics" },
      d = { "<CMD>TroubleToggle document_diagnostics<CR>", "Open document diagnostics" },
      q = { "<CMD>TroubleToggle quickfix<CR>", "Open trouble quickfix" },
      l = { "<CMD>TroubleToggle loclist<CR>", "Open trouble loclist" },
      r = { "<CMD>TroubleToggle lsp_references<CR>", "Open LSP references" },
    },
    p = {
      name = "+plugins",
      s = { "<Plug>RestNvim", "Run request under cursor" },
      p = { "<Plug>RestNvimPreview", "Preview request cURL command" },
      l = { "<Plug>RestNvimLast", "Re-run the last request" },
      r = {
        function()
          require("ssr").open()
        end,
        "Replace by ssr.nvim",
      },
      o = { "<CMD>SymbolsOutline<CR>", "Open symbols outlines tree" },
    },
    -----------------------------------------------------------
    -- tab split page shortcut key
    -----------------------------------------------------------
    t = {
      name = "+tab",
      s = { "<CMD>tab split<CR>", "Split window use tab" },
      h = { "<CMD>tabprev<CR>", "Switch to previous tab" },
      l = { "<CMD>tabnext<CR>", "Switch to next tab" },
      j = { "<CMD>tabfirst<CR>", "Switch to first tab" },
      k = { "<CMD>tablast<CR>", "Switch to last tab" },
      c = { "<CMD>tabclose<CR>", "Close tab" },
    },
    d = {
      name = "+debug",
      e = {
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
      c = {
        function()
          require("dap").continue()
        end,
        "Continue debug",
      },
      t = {
        function()
          require("dap").toggle_breakpoint()
        end,
        "Set breakpoint",
      },
      T = {
        function()
          require("dap").clear_breakpoints()
        end,
        "Clear breakpoint",
      },
      j = {
        function()
          require("dap").step_over()
        end,
        "Step over",
      },
      k = {
        function()
          require("dap").step_out()
        end,
        "Step out",
      },
      l = {
        function()
          require("dap").step_into()
        end,
        "Step into",
      },
      h = {
        function()
          require("dapui").eval()
        end,
        "Popups dapUI eval",
      },
    },
    r = {
      name = "+rust",
      r = {
        function()
          require("rust-tools.runnables").runnables()
        end,
        "Run runnables",
      },
      h = {
        function()
          require("rust-tools.hover_actions").hover_actions()
        end,
        "Hover actions",
      },
      a = {
        function()
          require("rust-tools.code_action_group").code_action_group()
        end,
        "Code actions",
      },
      d = {
        function()
          require("rust-tools.debuggables").debuggables()
        end,
        "Start debug",
      },
    },
    -----------------------------------------------------------
    -- s_windows split window shortcut key
    -----------------------------------------------------------
    s = {
      name = "+split",
      v = { ":vsp<CR>", "Split window vertically" },
      h = { ":sp<CR>", "Split window horizontally" },
      c = { "<C-w>c", "Close split window" },
      o = { "<C-w>o", "Close others split window" },
      [","] = { ":vertical resize -10<CR>", "Reduce vertical window size" },
      ["."] = { ":vertical resize +10<CR>", "Increase vertical window size" },
      j = { ":horizontal resize -5<CR>", "Reduce horizontal window size" },
      k = { ":horizontal resize +5<CR>", "Increase horizontal window size" },
      ["="] = { "<C-w>=", "Make split windows equal in size" },
    },

    -----------------------------------------------------------
    -- Gitsigns
    -----------------------------------------------------------
    g = {
      name = "+git",
      j = { "", "Diff, go to next hunk" },
      k = { "", "Diff, go to prev hunk" },
      s = { "", "Stage hunk" },
      S = { "", "Stage buffer" },
      u = { "", "Undo stage hunk" },
      r = { "", "Reset hunk" },
      R = { "", "Reset buffer" },
      p = { "", "Preview hunk" },
      b = { "", "Full blam line" },
      d = { "", "Diff current file" },
      D = { "", "Diff current directory" },
      t = {
        name = "+toggle",
        d = { "", "Toggle deleted" },
        D = { "", "Toggle current line blame" },
      },
    },
  },

  -- treesitter fold
  z = {
    name = "Folding",
    R = {
      function()
        ufo.openAllFolds()
      end,
      "Open all folds",
    },
    M = {
      function()
        ufo.closeAllFolds()
      end,
      "Close all folds",
    },
    r = {
      function()
        ufo.openFoldsExceptKinds()
      end,
      "Open all folds except kinds",
    },
    m = {
      function()
        ufo.closeFoldsWith()
      end,
      "Close fold with",
    },
    K = {
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
    o = { "<CMD>foldopen<CR>", "Open fold" },
    c = { "<CMD>foldclose<CR>", "Close fold" },
  },
})
