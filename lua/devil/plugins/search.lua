local notify = require("devil.shared.notify")

local telescope_keys = {
  {
    "<C-p>",
    function()
      require("telescope").extensions.smart_open.smart_open()
    end,
    desc = "Find files",
  },
  {
    "<leader>ff",
    function()
      require("telescope").extensions.smart_open.smart_open()
    end,
    desc = "Find files",
  },
  { "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", desc = "Find all" },
  { "<leader>fw", "<cmd> Telescope live_grep <CR>", desc = "Live grep" },
  {
    "<leader>fg",
    function()
      require("telescope").extensions.live_grep_args.live_grep_args()
    end,
    desc = "Live grep with args",
  },
  { "<leader>fb", "<cmd> Telescope buffers <CR>", desc = "Find buffers" },
  { "<leader>fh", "<cmd> Telescope help_tags <CR>", desc = "Help page" },
  { "<leader>fo", "<cmd> Telescope oldfiles <CR>", desc = "Find oldfiles" },
  { "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", desc = "Find in current buffer" },
  { "<leader>fp", "<cmd> Telescope project <CR>", desc = "Find recently projects" },
  { "<leader>fe", "<cmd> Telescope file_browser <CR>", desc = "File browser" },
}

local trouble_keys = {
  { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
  { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
  { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
  {
    "<leader>cl",
    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    desc = "LSP Definitions / references / ... (Trouble)",
  },
  { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
  { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
}

local which_key_keys = {
  {
    "<leader>wK",
    function()
      vim.cmd("WhichKey")
    end,
    desc = "Which-key all keymaps",
  },
  {
    "<leader>w?",
    function()
      local input = vim.fn.input("WhichKey: ")
      vim.cmd("WhichKey " .. input)
    end,
    desc = "Which-key query lookup",
  },
}

local function telescope_opts()
  local telescope = require("telescope")
  local mappings = {
    i = {
      ["<C-j>"] = "move_selection_next",
      ["<C-k>"] = "move_selection_previous",
      ["<Down>"] = "cycle_history_next",
      ["<Up>"] = "cycle_history_prev",
      ["<C-c>"] = "close",
      ["<C-u>"] = "preview_scrolling_up",
      ["<C-d>"] = "preview_scrolling_down",
    },
    n = {},
  }

  for _, name in ipairs({
    "agrolens",
    "file_browser",
    "fzf",
    "project",
    "smart_open",
    "undo",
    "live_grep_args",
    "workspaces",
    "ui-select",
  }) do
    local ok, err = pcall(telescope.load_extension, name)
    if not ok then
      notify.warn(("Failed to load telescope extension `%s`: %s"):format(name, err))
    end
  end

  local has_trouble, trouble_telescope = pcall(require, "trouble.sources.telescope")
  if has_trouble then
    mappings.i["<C-t>"] = trouble_telescope.open
    mappings.n["<C-t>"] = trouble_telescope.open
  end

  return require("devil.plugins.configs.telescope")
end

local function setup_which_key()
  local ok, which_key = pcall(require, "which-key")
  if not ok then
    notify.error("which-key.nvim not found")
    return
  end

  which_key.setup({
    preset = "classic",
    plugins = {
      marks = true,
      registers = true,
      spelling = { enabled = true, suggestions = 20 },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    win = {
      border = "rounded",
      padding = { 2, 2, 2, 2 },
    },
    show_help = true,
    show_keys = true,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt", "mason" },
    },
  })

  which_key.add({
    { "<leader>b", group = "Buffers" },
    { "<leader>c", group = "Code" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>l", group = "LSP" },
    { "<leader>n", group = "Notify" },
    { "<leader>p", group = "Profiler" },
    { "<leader>q", group = "Quit/Session" },
    { "<leader>t", group = "Toggle" },
    { "<leader>w", group = "Window/Save" },
    { "<leader>x", group = "Trouble/Diagnose" },
    { "<leader>y", group = "Yank" },
    { "s", group = "Split Window" },
    { "t", group = "Tabs" },
  })
end

return {
  {
    "danielfalk/smart-open.nvim",
    lazy = true,
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    build = "./kitty/install-kittens.bash",
    version = ">=1.0.0",
    keys = {
      {
        "<A-h>",
        function()
          require("smart-splits").resize_left()
        end,
        desc = "Resize window left",
      },
      {
        "<A-j>",
        function()
          require("smart-splits").resize_down()
        end,
        desc = "Resize window down",
      },
      {
        "<A-k>",
        function()
          require("smart-splits").resize_up()
        end,
        desc = "Resize window up",
      },
      {
        "<A-l>",
        function()
          require("smart-splits").resize_right()
        end,
        desc = "Resize window right",
      },
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Move window left",
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "Move window down",
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "Move window up",
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "Move window right",
      },
      {
        "<leader><leader>h",
        function()
          require("smart-splits").swap_buf_left()
        end,
        desc = "Swap buffer left",
      },
      {
        "<leader><leader>j",
        function()
          require("smart-splits").swap_buf_down()
        end,
        desc = "Swap buffer down",
      },
      {
        "<leader><leader>k",
        function()
          require("smart-splits").swap_buf_up()
        end,
        desc = "Swap buffer up",
      },
      {
        "<leader><leader>l",
        function()
          require("smart-splits").swap_buf_right()
        end,
        desc = "Swap buffer right",
      },
    },
    opts = {
      ignored_filetypes = { "nofile", "quickfix", "prompt" },
      ignored_buftypes = { "NvimTree" },
      default_amount = 3,
      at_edge = "wrap",
      move_cursor_same_row = false,
      cursor_follows_swapped_bufs = false,
      resize_mode = {
        quit_key = "<ESC>",
        resize_keys = { "h", "j", "k", "l" },
        silent = false,
        hooks = { on_enter = nil, on_leave = nil },
      },
      ignored_events = { "BufEnter", "WinEnter" },
      multiplexer_integration = nil,
      disable_multiplexer_nav_when_zoomed = true,
      kitty_password = nil,
      log_level = "info",
    },
  },
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    cmd = { "SnipRun" },
    opts = function()
      local hl = require("devil.shared.highlight")
      return {
        selected_interpreters = {},
        repl_enable = {},
        repl_disable = {},
        interpreter_options = {
          GFM_original = { use_on_filetypes = { "markdown.pandoc" } },
          Python3_original = { error_truncate = "auto" },
        },
        display = { "Classic", "VirtualTextOk", "NvimNotify" },
        live_display = { "VirtualTextOk" },
        display_options = { terminal_width = 45, notification_timeout = 5 },
        show_no_output = { "Classic", "TempFloatingWindow" },
        snipruncolors = {
          SniprunVirtualTextOk = hl.style({
            fg = { { "Normal", "bg" }, { "NormalFloat", "bg" }, { "Normal", "fg" } },
            bg = { { "DiffAdd", "bg" }, { "String", "fg" }, { "MoreMsg", "fg" } },
          }),
          SniprunFloatingWinOk = hl.style({ fg = { { "DiffAdd", "fg" }, { "String", "fg" }, { "MoreMsg", "fg" } } }),
          SniprunVirtualTextErr = hl.style({
            fg = { { "Normal", "bg" }, { "NormalFloat", "bg" }, { "Normal", "fg" } },
            bg = { { "DiffDelete", "bg" }, { "DiagnosticError", "fg" }, { "ErrorMsg", "fg" } },
          }),
          SniprunFloatingWinErr = hl.style({
            fg = { { "DiagnosticError", "fg" }, { "DiffDelete", "fg" }, { "ErrorMsg", "fg" } },
          }),
        },
        live_mode_toggle = "off",
        inline_messages = 0,
        borders = "rounded",
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "desdic/agrolens.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    version = "^0.2",
    keys = telescope_keys,
    opts = telescope_opts,
  },
  { "johmsalas/text-case.nvim", lazy = true },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "󰅒 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = "󰍨 ", color = "hint", alt = { "INFO" } },
      },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = "nvim-mini/mini.icons",
    keys = trouble_keys,
    opts = { use_diagnostic_signs = true },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = which_key_keys,
    config = setup_which_key,
  },
  {
    "natecraddock/workspaces.nvim",
    cmd = {
      "WorkspacesAdd",
      "WorkspacesAddDir",
      "WorkspacesRemove",
      "WorkspacesRemoveDir",
      "WorkspacesRename",
      "WorkspacesList",
      "WorkspacesListDirs",
      "WorkspacesOpen",
      "WorkspacesSyncDirs",
    },
    opts = { hooks = { open = { "Telescope find_files" } } },
  },
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
    },
  },
  {
    "kevinhwang91/nvim-hlslens",
    init = function()
      local map_opts = { noremap = true, silent = true }
      vim.keymap.set(
        "n",
        "n",
        "<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>",
        map_opts
      )
      vim.keymap.set(
        "n",
        "N",
        "<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require('hlslens').start()<CR>",
        map_opts
      )
      vim.keymap.set("n", "*", "*<cmd>lua require('hlslens').start()<CR>", map_opts)
      vim.keymap.set("n", "#", "#<cmd>lua require('hlslens').start()<CR>", map_opts)
      vim.keymap.set("n", "g*", "g*<cmd>lua require('hlslens').start()<CR>", map_opts)
      vim.keymap.set("n", "g#", "g#<cmd>lua require('hlslens').start()<CR>", map_opts)
    end,
    opts = {
      build_position_cb = function(plist)
        require("scrollbar.handlers.search").handler.show(plist.start_pos)
      end,
    },
  },
}
