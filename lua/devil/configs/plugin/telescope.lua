local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("telescope not found", "error")
  return
end

local utils = require("devil.utils")

local trouble = require("trouble.providers.telescope")
local builtin = require("telescope.builtin")
local extensions = require("telescope").extensions

local extensions_list = {
  "aerial",
  "agrolens",
  "env",
  "file_browser",
  "fzf",
  "neoclip",
  "noice",
  "persisted",
  "project",
  "scope",
  "smart_open",
  "ui-select",
}

for _, value in pairs(extensions_list) do
  telescope.load_extension(value)
end

local opts = {
  defaults = {
    initial_mode = "insert",
    -- vertival, center, cursor
    layout_strategy = "horizontal",
    -- shortcut keys in the window
    mappings = {
      i = {
        -- move up and down
        ["C-j"] = "move_selection_next",
        ["C-k"] = "move_selection_previous",
        -- history records
        ["<Down>"] = "cycle_history_next",
        ["<Up>"] = "cycle_history_prev",
        -- close window
        ["<C-c>"] = "close",
        -- scroll the preview window up and down
        ["<C-u>"] = "preview_scrolling_up",
        ["<C-d>"] = "preview_scrolling_down",
        -- trouble.nvim support
        ["<C-T>"] = trouble.open_with_trouble,
      },
      n = {
        ["<C-t>"] = trouble.open_with_trouble,
      },
    },
  },
  pickers = {
    -- built-in pickers configurate
    find_files = {
      -- theme = 'dropdown',
    },
  },
  extensions = {
    -- extension configure
    aerial = {
      -- Display symbols as <root>.<parent>.<symbol>
      show_nesting = {
        ["_"] = false, -- This key will be the default
        json = true, -- You can set the option for specific filetypes
        yaml = true,
      },
    },
    agrolens = {
      debug = false,
      same_type = true,
      include_hidden_buffers = false,
      disable_indentation = false,
      aliases = {},
    },
    file_browser = {
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    persisted = {
      layout_config = { width = 0.55, height = 0.55 },
    },
    smart_open = {
      cwd_only = true,
      filename_first = false,
      show_scores = false,
      ignore_patterns = { "*.git/*", "*/tmp/*" },
      match_algorithm = "fzy",
      disable_devicons = false,
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        -- even more opts
        initial_mode = "normal",
      }),
    },
  },
}

telescope.setup(opts)

utils.keymap("n", "<C-p>", function()
  extensions.smart_open.smart_open()
end)
utils.keymap("n", "<C-f>", builtin.live_grep)

utils.keymap("n", "<space>fb", "<CMD>Telescope file_browser<CR>")
utils.keymap("n", "<space>no", "<CMD>Telescope noice<CR>")
utils.keymap("n", "<space>cl", "<CMD>Telescope neoclip<CR>")
utils.keymap("n", "<space>pj", "<CMD>Telescope project<CR>")
utils.keymap("n", "<space>ps", "<CMD>Telescope persisted<CR>")
