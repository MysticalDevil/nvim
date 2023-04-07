local status, lualine = pcall(require, "lualine")
if not status then
  vim.notify("lualine not found", "error")
  return
end

local colors = require("onedark.colors")

local navic = require("nvim-navic")

local aerial = {
  "aerial",

  sep = " > ", -- The separator to be used to separate symbols in status line.

  -- The number of symbols to render top-down. In order to render only 'N' last
  -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
  -- be used in order to render only current symbol.
  depth = nil,

  -- When 'dense' mode is on, icons are not rendered near their symbols. Only
  -- a single icon that represents the kind of current symbol is rendered at
  -- the beginning of status line.
  dense = false,

  dense_sep = ".", -- The separator to be used to separate symbols in dense mode.

  colored = true, -- Color the symbol icons.
}

local nvim_navic = {
  navic.get_location,
  cond = navic.is_available,
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
    readonly = " ", -- Text to show when the file is non-modifiable or readonly.
    unnamed = "[No Name]", -- Text to show for unnamed buffers.
    newfile = "[New]", -- Text to show for new created file before first writting
  },
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
  extensions = { "nvim-tree", "toggleterm" },
  sections = {
    lualine_c = {
      filename,
      {
        "lsp_progress",
        spinner_symbols = { "", "", "", "", "", "" },
      },
    },
    lualine_x = {
      "filesize",
      {
        "fimeformat",
        -- symbols = {
        --   bsd = '', -- f30c
        --   linux = '', -- ebc6
        --   dos = '', -- e70f
        --   mac = '', --e711
        -- }
        symbols = {
          unix = "LF",
          dos = "CRLF",
          mac = "CR",
        },
      },
      "encoding",
      "filetype",
    },
  },
  winbar = {
    lualine_a = { diagnostics },
    lualine_b = { nvim_navic },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}

lualine.setup(opts)
