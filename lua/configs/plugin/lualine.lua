local status, lualine = pcall(require, "lualine")
if not status then
  vim.notify("lualine not found", "error")
  return
end

local colors = require("onedark.colors")

local navic = require("nvim-navic")

local nvim_navic = {
  function()
    return navic.get_location()
  end,
  cond = function()
    return navic.is_available()
  end,
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

  diagnostics_color = {
    -- Same values as the general color option can be used here.
    error = { fg = colors.red, bg = colors.grey },
    warn = { fg = colors.yellow, bg = colors.grey },
    info = { fg = colors.blue, bg = colors.grey },
    hint = { fg = colors.cyan, bg = colors.grey },
  },
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
}

local lsp_progress = {
  "lsp_progress",
  colors = {
    percentage = colors.cyan,
    title = colors.cyan,
    message = colors.cyan,
    spinner = colors.cyan,
    lsp_client_name = colors.magenta,
    use = true,
  },
  separators = {
    component = " ",
    progress = " | ",
    percentage = { pre = "", post = "%% " },
    title = { pre = "", post = ": " },
    lsp_client_name = { pre = "[", post = "]" },
    spinner = { pre = "", post = "" },
    message = { pre = "(", post = ")", commenced = "In Progress", completed = "Completed" },
  },
  display_components = { "lsp_client_name", "spinner" },
  timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
  spinner_symbols = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " },
}

local opts = {
  options = {
    theme = "onedark",
    component_separators = { left = "|", right = "|" },
    -- https://github.com/ryanoasis/powerline-extra-symbols
    section_separators = { left = "", right = "" },
    globalstatus = true,
    disabled_filetypes = {
      statusline = { "alpha" },
      winbar = { "alpha", "aerial", "neo-tree", "nerdtree", "NvimTree" },
    },
  },
  extensions = { "toggleterm" },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = { lsp_progress },
    lualine_x = {
      "filesize",
      {
        "fileformat",
        symbols = {
          unix = "LF",
          dos = "CRLF",
          mac = "CR",
        },
      },
      "encoding",
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  winbar = {
    lualine_a = { diagnostics },
    lualine_b = {},
    lualine_c = { nvim_navic },
    lualine_x = { filename, "selectioncount" },
    lualine_y = {},
    lualine_z = {},
  },
}

lualine.setup(opts)
