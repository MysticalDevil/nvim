local status, lualine = pcall(require, "lualine")
if not status then
  vim.notify("lualine not found")
  return
end

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
      "filename",
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
    lualine_a = {},
    lualine_b = {},
    lualine_c = { aerial },
    lualine_x = {
      { -- Let winbar always visible
        function()
          return " "
        end,
        padding = 0,
      },
    },
    lualine_y = {},
    lualine_z = {},
  },
}

lualine.setup(opts)
