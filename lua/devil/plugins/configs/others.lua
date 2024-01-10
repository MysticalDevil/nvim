local M = {}

M.beacon = {
  enable = true,
  size = 40,
  fade = true,
  minimal_jump = 10,
  show_jumps = true,
  focus_gained = false,
  shrink = true,
  timeout = 500,
  ignore_buffers = {},
  ignore_filetypes = {},
}

M.neogen = {
  enabled = true, --if you want to disable Neogen
  input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
  snippet_engine = "luasnip",
}

M.neoscroll = {
  -- All these keys will be mapped to their corresponding default scrolling animation
  -- mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
  mappings = { "<C-u>", "<C-d>", "<A-b>", "<A-f>" },
  hide_cursor = true, -- Hide cursor while scrolling
  stop_eof = true, -- Stop at <EOF> when scrolling downwards
  respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  easing_function = nil, -- Default easing function
  pre_hook = nil, -- Function to run before the scrolling animation starts
  post_hook = nil, -- Function to run after the scrolling animation ends
  performance_mode = false, -- Disable "Performance Mode" on all buffers.
}

M.neorg = {
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/Notes",
        },
        default_workspace = "notes",
      },
    },
  },
}

M.autopairs = {
  check_ts = true,
  ts_config = {
    -- lua = { "string" }, -- it will not add a piar on that treesitter node
    -- javascript = { "template_string" },
    -- java = false, -- don't check treesitter on java
    fennel = false,
  },
  disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
}

M.smartcolumn = {
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
  },
  custom_colorcolumn = {},
  scope = "file",
}

M.ssr = {
  border = "rounded",
  min_width = 50,
  min_height = 5,
  max_width = 120,
  max_height = 25,
  adjust_window = true,
  keymaps = {
    close = "q",
    next_match = "n",
    prev_match = "N",
    replace_confirm = "<cr>",
    replace_all = "<leader><cr>",
  },
}

M.todo_comments = {
  keywords = {
    FIX = {
      icon = " ", -- icon used for the sign, and in search results
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = "󰅒 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = "󰍨 ", color = "hint", alt = { "INFO" } },
  },
}

M.toggleterm = {
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.3
    end
  end,
  start_in_insert = true,
}

M.treesj = {
  ---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
  use_default_keymaps = false,
  ---@type boolean Node with syntax error will not be formatted
  check_syntax_error = true,
  ---If line after join will be longer than max value,
  ---@type number If line after join will be longer than max value, node will not be formatted
  max_join_length = 120,
  ---Cursor behavior:
  ---hold - cursor follows the node/place on which it was called
  ---start - cursor jumps to the first symbol of the node being formatted
  ---end - cursor jumps to the last symbol of the node being formatted
  ---@type 'hold'|'start'|'end'
  cursor_behavior = "hold",
  ---@type boolean Notify about possible problems or not
  notify = true,
  ---@type boolean Use `dot` for repeat action
  dot_repeat = true,
  ---@type nil|function Callback for treesj error handler. func (err_text, level, ...other_text)
  on_error = nil,
}

M.luasnip = function(opts)
  require("luasnip").config.set_config(opts)

  -- vscode format
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })

  -- snipmate format
  require("luasnip.loaders.from_snipmate").load()
  require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.snipmate_snippets_path or "" })

  -- lua format
  require("luasnip.loaders.from_lua").load()
  require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      if
        require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })
end

return M
