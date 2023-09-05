local status, lualine = pcall(require, "lualine")
if not status then
  vim.notify("lualine not found", "error")
  return
end

local navic = require("nvim-navic")

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
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

local fileformat = {
  "fileformat",
  symbols = {
    unix = "LF",
    dos = "CRLF",
    mac = "CR",
  },
}

local lsp_status = {
  function()
    local msg = "No Active LSP"
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    if #clients == 1 and clients[1].name ~= "null-ls" then
      return clients[1].name
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
        return client.name
      end
    end
    return msg
  end,
  icon = " LSP:",
  color = { fg = "#a0a0a0", gui = "bold" },
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

local opts = {
  options = {
    theme = "auto",
    component_separators = { left = "|", right = "|" },
    -- https://github.com/ryanoasis/powerline-extra-symbols
    section_separators = { left = "", right = "" },
    globalstatus = true,
    disabled_filetypes = {
      statusline = { "alpha" },
      winbar = { "alpha", "aerial", "neo-tree", "nerdtree", "NvimTree", "dashboard", "Trouble", "DiffViewFiles" },
    },
  },
  extensions = { "toggleterm", "aerial" },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { branch, diff },
    lualine_c = { filename },
    lualine_x = {
      "filesize",
      fileformat,
      "encoding",
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  winbar = {
    lualine_a = {},
    lualine_b = { diagnostics },
    lualine_c = { nvim_navic },
    lualine_x = { lsp_status, "selectioncount" },
    lualine_y = {},
    lualine_z = {},
  },
}

lualine.setup(opts)

-- local git_status = {
--   function()
--     if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
--       return ""
--     end
--
--     local git_status = vim.b.gitsigns_status_dict
--
--     local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
--     local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
--     local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
--     local branch_name = "  " .. git_status.head
--
--     return branch_name .. added .. changed .. removed
--   end,
-- }
