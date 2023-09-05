local commonAutoGroup = vim.api.nvim_create_augroup("commonAutoGroup", {
  clear = true,
})
local lspAutoGroup = vim.api.nvim_create_augroup("lspAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

local lispFiletypes = { "clj", "*.el", "*.fnl", "*.hy", "*.janet", "*.lisp", "*.rkt", "*.scm" }

-- Terminal mode automatically enters insert mode
autocmd("TermOpen", {
  group = commonAutoGroup,
  command = "startinsert",
})

-- Newlines with `o` do not continue comments
autocmd("BufEnter", {
  group = commonAutoGroup,
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - "o" + "r"
  end,
})

-- Auto lint after writing to the file
-- autocmd("BufWritePost", {
--   group = lspAutoGroup,
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })

-- Auto enable parinfer when edit lisp file
autocmd({ "BufEnter", "BufWinEnter" }, {
  group = "commonAutoGroup",
  pattern = lispFiletypes,
  command = "ParinferOn",
})
