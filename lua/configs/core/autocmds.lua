local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local commonAutoGroup = augroup("commonAutoGroup", { clear = true })
local indentAutoGroup = augroup("indentAutoGroup", { clear = true })

local lispFiletypes = { "clj", "*.el", "*.fnl", "*.hy", "*.janet", "*.lisp", "*.rkt", "*.scm" }

-- Terminal mode automatically enters insert mode
autocmd("TermOpen", {
  group = commonAutoGroup,
  command = "startinsert",
})

autocmd("BufEnter", {
  group = commonAutoGroup,
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - "o" + "r"
  end,
  desc = "newlines with `o` do not continue comments",
})

-- Auto enable parinfer for lisp-like languages
autocmd({ "BufEnter", "BufWinEnter" }, {
  group = commonAutoGroup,
  pattern = lispFiletypes,
  desc = "Auto enable brackets matching for lisp files",
  command = "ParinferOn",
})

-- Auto disable side line number for some filetypes
autocmd("FileType", {
  group = commonAutoGroup,
  pattern = { "nvim-docs-view" },
  desc = "Auto disable side line number for some filetypes",
  callback = function()
    vim.opt.number = false
  end,
})

-- Auto set indent for some filetypes
autocmd("FileType", {
  group = indentAutoGroup,
  pattern = { "java", "kotlin", "c", "cpp" },
  desc = "Auto set indent for some languages",
  callback = function()
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.expandtab = false
  end,
})

-- Add new file types
autocmd({ "BufRead", "BufNewFile" }, {
  group = commonAutoGroup,
  pattern = { "*.ixx" },
  desc = "Set *.ixx file's filetype as ixx",
  callback = function()
    vim.bo.filetype = "ixx"
  end,
})
autocmd({ "BufRead", "BufNewFile" }, {
  group = commonAutoGroup,
  pattern = { "*.mpp" },
  desc = "Set *.mpp file's filetype as mpp",
  callback = function()
    vim.bo.filetype = "mpp"
  end,
})
autocmd({ "BufRead", "BufNewFile" }, {
  group = commonAutoGroup,
  pattern = { "*.v", "*.vv", "*.vsh", "*.vlang" },
  desc = "Set filetype as vlang",
  callback = function()
    vim.bo.filetype = "vlang"
  end,
})
