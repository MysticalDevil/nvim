local function bufferline_keys()
  return {
    { "<C-h>", "<CMD>BufferLineCyclePrev<CR>", desc = "Cycle previous buffer" },
    { "<C-l>", "<CMD>BufferLineCycleNext<CR>", desc = "Cycle next buffer" },
    { "<A-<>", "<CMD>BufferLineMovePrev<CR>", desc = "Move buffer to previous" },
    { "<A->>", "<CMD>BufferLineMoveNext<CR>", desc = "Move buffer to next" },
    { "<A-1>", "<CMD>BufferLineGoToBuffer 1<CR>", desc = "Go to 1 buffer" },
    { "<A-2>", "<CMD>BufferLineGoToBuffer 2<CR>", desc = "Go to 2 buffer" },
    { "<A-3>", "<CMD>BufferLineGoToBuffer 3<CR>", desc = "Go to 3 buffer" },
    { "<A-4>", "<CMD>BufferLineGoToBuffer 4<CR>", desc = "Go to 4 buffer" },
    { "<A-5>", "<CMD>BufferLineGoToBuffer 5<CR>", desc = "Go to 5 buffer" },
    { "<A-6>", "<CMD>BufferLineGoToBuffer 6<CR>", desc = "Go to 6 buffer" },
    { "<A-7>", "<CMD>BufferLineGoToBuffer 7<CR>", desc = "Go to 7 buffer" },
    { "<A-8>", "<CMD>BufferLineGoToBuffer 8<CR>", desc = "Go to 8 buffer" },
    { "<A-9>", "<CMD>BufferLineGoToBuffer 9<CR>", desc = "Go to 9 buffer" },
    { "<A-0>", "<CMD>BufferLineGoToBuffer -1<CR>", desc = "Go to first buffer" },
    { "<A-p>", "<CMD>BufferLineTogglePin<CR>", desc = "Toggle pinned buffer" },
    { "<Space>bt", "<Cmd>BufferLineSortByTabs<CR>", desc = "Sort buffers by tabs" },
    { "<Space>bd", "<Cmd>BufferLineSortByDirectory<CR>", desc = "Sort buffers by directories" },
    { "<Space>be", "<Cmd>BufferLineSortByExtension<CR>", desc = "Sort buffers by extensions" },
    {
      "<leader>ba",
      function()
        Snacks.bufdelete.all()
      end,
      desc = "Close all buffers",
    },
    { "<leader>bb", "<cmd>b#<CR>", desc = "Switch to alternate buffer" },
    {
      "<leader>bc",
      function()
        Snacks.bufdelete.delete()
      end,
      desc = "Close current buffer",
    },
    { "<leader>bd", "<CMD>BufferLinePickClose<CR>", desc = "Pick and close buffer" },
    { "<leader>bh", "<CMD>BufferLineCloseLeft<CR>", desc = "Close left buffer" },
    { "<leader>bl", "<CMD>BufferLineCloseRight<CR>", desc = "Close right buffer" },
    {
      "<leader>bo",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Close other buffers",
    },
    { "<leader>bp", "<CMD>BufferLinePick<CR>", desc = "Pick buffer" },
    { "<leader>bt", "<CMD>BufferLineTogglePin<CR>", desc = "Toggle pinned buffer" },
  }
end

local function on_neo_tree_move(data)
  local snacks = package.loaded["snacks"]
  if snacks and snacks.rename and snacks.rename.on_rename_file then
    snacks.rename.on_rename_file(data.source, data.destination)
    return
  end

  local ok, loaded_snacks = pcall(require, "snacks")
  if ok and loaded_snacks.rename and loaded_snacks.rename.on_rename_file then
    loaded_snacks.rename.on_rename_file(data.source, data.destination)
  end
end

return {
  {
    "akinsho/bufferline.nvim",
    branch = "main",
    event = "VeryLazy",
    keys = bufferline_keys(),
    opts = function()
      return require("devil.plugins.configs.bufferline")
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    event = "VeryLazy",
    keys = {
      {
        "<c-\\>",
        function()
          Snacks.terminal.toggle()
        end,
        desc = "Toggle Terminal",
        mode = { "n", "t" },
      },
      {
        "<leader>cR",
        function()
          Snacks.rename.rename_file()
        end,
        desc = "Rename File",
      },
      {
        "<leader>z",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>Z",
        function()
          Snacks.zen.zoom()
        end,
        desc = "Toggle Zoom",
      },
      {
        "<leader>pS",
        function()
          Snacks.profiler.startup({})
        end,
        desc = "Startup Profiler",
      },
      {
        "<leader>n",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
      {
        "<leader>gB",
        function()
          Snacks.git.blame_line()
        end,
        desc = "Git Blame Line",
      },
      {
        "<leader>N",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
        desc = "Neovim News",
      },
    },
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          header = [[
   __  __           _   _           _
  |  \/  |_   _ ___| |_(_) ___ __ _| |
  | |\/| | | | / __| __| |/ __/ _` | |
  | |  | | |_| \__ \ |_| | (_| (_| | |
  |_|  |_|\__, |___/\__|_|\___\__,_|_|
          |___/
      ]],
        },
      },
      dim = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      terminal = { enabled = true },
      zen = {
        enabled = true,
        toggles = {
          dim = true,
          git_signs = true,
          mini_diff_signs = false,
        },
      },
    },
  },
  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = "130",
      disabled_filetypes = {
        "help",
        "text",
        "markdown",
        "alpha",
        "aerial",
        "neo-tree",
        "nerdtree",
        "NvimTree",
        "dashboard",
        "Trouble",
        "DiffViewFiles",
        "dapui_stacks",
        "dapui_scopes",
        "dapui_watches",
        "dapui_breakpoints",
        "dapui_console",
        "dap-repl",
        "mason",
      },
      custom_colorcolumn = {},
      scope = "file",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "UIEnter",
    dependencies = { "nvim-mini/mini.icons" },
    opts = function()
      return require("devil.plugins.configs.lualine")
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    branch = "v3.x",
    cmd = { "Neotree" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-mini/mini.icons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<A-m>", "<cmd>Neotree toggle<CR>", desc = "Toggle neo-tree" },
      { "\\", "<cmd>Neotree reveal<CR>", desc = "Reveal neo-tree" },
    },
    opts = function(_, opts)
      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_neo_tree_move },
        { event = events.FILE_RENAMED, handler = on_neo_tree_move },
      })
      return require("devil.plugins.configs.neo-tree")
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    },
  },
  {
    "catgoose/nvim-colorizer.lua",
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
      "ColorizerToggle",
    },
  },
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle symbols outline tree" },
    },
    opts = function()
      return require("devil.plugins.configs.outline")
    end,
  },
  {
    "Bekaboo/dropbar.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    opts = function()
      return require("devil.plugins.configs.dropbar")
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    version = "v2.*",
    opts = function()
      return require("devil.plugins.configs.window-picker")
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    opts = function()
      require("devil.plugins.configs.scrollbar")
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
}
