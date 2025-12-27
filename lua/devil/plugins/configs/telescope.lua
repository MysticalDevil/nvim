local telescope = require("telescope")

local mappings = {
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
  },
  n = {},
}

local extensions_list = {
  "agrolens",
  "env",
  "file_browser",
  "fzf",
  "neoclip",
  "persisted",
  "project",
  "smart_open",
  "ui-select",
  "undo",
  "live_grep_args",
  "workspaces",
}

for _, value in pairs(extensions_list) do
  telescope.load_extension(value)
end

local has_trouble, trouble_telescope = pcall(require, "trouble.sources.telescope")
if has_trouble then
  mappings.i["<C-t>"] = trouble_telescope.open
  mappings.n["<C-t>"] = trouble_telescope.open
end

return {
  defaults = {
    initial_mode = "insert",
    -- vertival, center, cursor
    layout_strategy = "horizontal",
    -- shortcut keys in the window
    mappings = mappings,
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
  },
  pickers = {
    -- built-in pickers configurate
    find_files = {
      -- theme = 'dropdown',
    },
  },
  extensions = {
    agrolens = {
      debug = false,
      same_type = true,
      include_hidden_buffers = false,
      disable_indentation = false,
      aliases = {},
    },
    file_browser = {
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = false,
      mappings = {},
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
    undo = {
      use_delta = true,
      use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
      side_by_side = false,
      diff_context_lines = vim.o.scrolloff,
      entry_format = "state #$ID, $STAT, $TIME",
      time_format = "",
      mappings = {
        i = {
          -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
          -- you want to replicate these defaults and use the following actions. This means
          -- installing as a dependency of telescope in it's `requirements` and loading this
          -- extension from there instead of having the separate plugin definition as outlined
          -- above.
          ["<cr>"] = require("telescope-undo.actions").yank_additions,
          ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
          ["<C-cr>"] = require("telescope-undo.actions").restore,
        },
      },
    },
    workspaces = {
      -- keep insert mode after selection in the picker, default is false
      keep_insert = true,
    },
  },
}
