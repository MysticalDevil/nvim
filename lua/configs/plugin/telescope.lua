local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("telescope not found", "error")
  return
end

local utils = require("utils.setup")
local trouble = require("trouble.providers.telescope")

local opts = {
  defaults = {
    initial_mode = "insert",
    -- vertival, center, cursor
    layout_strategy = "horizontal",
    -- shortcut keys in the window
    mappings = {
      i = {
        -- move up and down
        ["cj"] = "move_selection_next",
        ["ck"] = "move_selection_previous",
        -- history records
        ["<Down>"] = "cycle_history_next",
        ["<Up>"] = "cycle_history_prev",
        -- close window
        ["<C-c>"] = "close",
        -- scroll the preview window up and down
        ["<C-u>"] = "preview_scrolling_up",
        ["<C-d>"] = "preview_scrolling_down",
        -- trouble.nvim support
        ["<C-t>"] = trouble.open_with_trouble,
        -- whick-key.nvim support
        ["<C-h>"] = "which_key",
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
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        -- even more opts
        initial_mode = "normal",
      }),
    },
  },
}

telescope.setup(opts)

utils.keymap("n", "<C-p>", ":Telescope find_files<CR>")
utils.keymap("n", "<C-f>", ":Telescope live_grep<CR>")

pcall(telescope.load_extension, "env")
pcall(telescope.load_extension, "ui-select")
pcall(telescope.load_extension, "noice")
pcall(telescope.load_extension, "neoclip")
pcall(telescope.load_extension, "aerial")

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
telescope.setup({
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    aerial = {
      -- Display symbols as <root>.<parent>.<symbol>
      show_nesting = {
        ["_"] = false, -- This key will be the default
        json = true, -- You can set the option for specific filetypes
        yaml = true,
      },
    },
  },
})
