local commonAutoGroup = vim.api.nvim_create_augroup("commonAutoGroup", { clear = true })

local autocmd = vim.api.nvim_create_autocmd

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

autocmd({ "BufEnter", "BufWinEnter" }, {
  group = "commonAutoGroup",
  pattern = lispFiletypes,
  command = "ParinferOn",
  desc = "Auto enable brackets matching for lisp files",
})
