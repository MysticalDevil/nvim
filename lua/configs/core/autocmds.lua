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
  command = "ParinferOn",
  desc = "Auto enable brackets matching for lisp files",
})

-- Auto disable side line number for some filetypes
autocmd("FileType", {
  group = commonAutoGroup,
  pattern = { "nvim-doc-view" },
  callback = function()
    vim.opt.number = false
  end,
  desc = "Auto disable side line number for some filetypes",
})

-- Auto set indent for some filetypes
autocmd("FileType", {
  group = indentAutoGroup,
  pattern = { "java", "kotlin", "c", "cpp" },
  callback = function()
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.expandtab = false
  end,
  desc = "Auto set indent for some languages",
})
