local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local commonAutoGroup = augroup("commonAutoGroup", { clear = true })
-- local writeAutoGroup = augroup("writeAutoGroup", { clear = true })

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
