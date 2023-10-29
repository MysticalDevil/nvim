local status, which_key = pcall(require, "which-key")
if not status then
  vim.notify("which-key not found", "error")
  return
end

local ufo = require("ufo")

local opts = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
  -- disable the WhichKey popup for certain buf types and file types.
  -- Disabled by deafult for Telescope
  disable = {
    buftypes = {},
    filetypes = { "TelescopePrompt" },
  },
}

which_key.setup(opts)

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
    "Toggle signature",
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
