local utils = require("devil.utils")

local get_highlight = require("lualine.utils.utils").extract_highlight_colors

-- Color table for highlights
local colors = {
  bg = get_highlight("Folded", "bg"),
  fg = get_highlight("Folded", "fg"),
  yellow = get_highlight("DiagnosticWarn", "fg"),
  green = get_highlight("String", "fg"),
  blue = get_highlight("Function", "fg"),
  red = get_highlight("DiagnosticError", "fg"),
  orange = get_highlight("Number", "fg"),
  cyan = get_highlight("Constant", "fg"),
  darkblue = get_highlight("DiffFile", "fg"),
  violet = "#e5d0ff",
  magenta = "#ff00ff",
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local opts = {
  options = {
    theme = {
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
    component_separators = "",
    section_separators = "",
    ignore_focus = { "neo-tree", "dropbar_menu" },
    globalstatus = true,
    disabled_filetypes = {
      statusline = { "alpha" },
      winbar = {
        "alpha",
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
    },
  },
  extensions = { "toggleterm" },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  winbar = {
    lualine_a = {
      {
        "%{%v:lua.dropbar()%}",
        separator = { left = "", right = "" },
        color = "nil",
        padding = { left = 0, right = 0 },
      },
    },
    lualine_x = {},
  },
}

---@param component string|function|table
---@param locate string
local function ins_section(component, locate)
  table.insert(opts.sections[locate], component)
end

local head = {
  function()
    return "▊"
  end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
}

local mode_color = {
  n = colors.red,
  i = colors.green,
  v = colors.blue,
  [""] = colors.blue,
  V = colors.blue,
  c = colors.magenta,
  no = colors.red,
  s = colors.orange,
  S = colors.orange,
  [""] = colors.orange,
  ic = colors.yellow,
  R = colors.violet,
  Rv = colors.violet,
  cv = colors.red,
  ce = colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ["r?"] = colors.cyan,
  ["!"] = colors.red,
  t = colors.red,
}

local mode = {
  function()
    return " " .. tostring(vim.fn.mode()):upper()
  end,
  color = { fg = mode_color[vim.fn.mode()] },
  padding = { right = 1 },
}

local branch = {
  "branch",
  icon = "",
  color = { fg = colors.violet, gui = "bold" },
}

local diff = {
  "diff",
  -- Is it me or the symbol for modified us really weird
  symbols = { added = " ", modified = " ", removed = " " },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

local diagnostics = {
  "diagnostics",

  -- Table of diagnostic sources, available sources are:
  --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
  -- or a function that returns a table as such:
  --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
  sources = { "nvim_lsp" },

  -- Displays diagnostics for the defined severity types
  sections = { "error", "warn", "info", "hint" },
}

local filename = {
  "filename",
  file_status = true, -- Displays file status (readonly status, modified status)
  newfile_status = true, -- Display new file status (new file means no write after created)
  path = 1, -- 0: Just the filename
  -- 1: Relative path
  -- 2: Absolute path
  -- 3: Absolute path, with tilde as the home directory

  shorting_target = 40, -- Shortens path to leave 40 spaces in the window

  -- for other components. (terrible name, any suggestions?)
  symbols = {
    modified = "[*]", -- Text to show when the file is modified.
    readonly = "󰌾 ", -- Text to show when the file is non-modifiable or readonly.
    unnamed = "[No Name]", -- Text to show for unnamed buffers.
    newfile = "[New]", -- Text to show for new created file before first writting
  },
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magentam, gui = "bold" },
}

local lsp_info = {
  utils.get_lsp_info,
  icon = "󰒋 LSP:",
  color = {
    fg = colors.green,
    gui = "bold",
  },
}

local filesize = {
  "filesize",
  cond = conditions.buffer_not_empty,
}

local fileformat = {
  "fileformat",
  symbols = {
    unix = "LF",
    dos = "CRLF",
    mac = "CR",
  },
}

local encoding = {
  "o:encoding",
  fmt = string.upper,
  cond = conditions.hide_in_width,
  color = { fg = colors.blue, gui = "bold" },
}

ins_section(head, "lualine_a")
ins_section(mode, "lualine_a")

ins_section(branch, "lualine_b")
ins_section(diff, "lualine_b")

ins_section(diagnostics, "lualine_c")
ins_section(filename, "lualine_c")

ins_section(lsp_info, "lualine_x")
ins_section(filesize, "lualine_x")
ins_section(fileformat, "lualine_x")
ins_section(encoding, "lualine_x")
ins_section("filetype", "lualine_x")

ins_section("process", "lualine_y")

ins_section("location", "lualine_z")

return opts
