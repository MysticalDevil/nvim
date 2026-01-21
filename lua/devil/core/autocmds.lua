local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local commonAugroup = augroup("commonAugroup", { clear = true })
-- local writeAutoGroup = augroup("writeAutoGroup", { clear = true })

local lispFiletypes = { "clj", "*.el", "*.fnl", "*.hy", "*.janet", "*.lisp", "*.rkt", "*.scm" }

-- Terminal mode automatically enters insert mode
autocmd("TermOpen", {
  group = commonAugroup,
  command = "startinsert",
})

autocmd("BufEnter", {
  group = commonAugroup,
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - "o" + "r"
  end,
  desc = "newlines with `o` do not continue comments",
})

-- Auto enable parinfer for lisp-like languages
autocmd({ "BufEnter", "BufWinEnter" }, {
  group = commonAugroup,
  pattern = lispFiletypes,
  desc = "Auto enable brackets matching for lisp files",
  command = "ParinferOn",
})

-- Auto disable side line number for some filetypes
autocmd("FileType", {
  group = commonAugroup,
  pattern = { "nvim-docs-view" },
  desc = "Auto disable side line number for some filetypes",
  callback = function()
    vim.opt.number = false
  end,
})

autocmd("TextYankPost", {
  group = commonAugroup,
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight on yank",
})

autocmd("BufReadPost", {
  group = commonAugroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Go to last loc when opening a buffer",
})
