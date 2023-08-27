local commonAutoGroup = vim.api.nvim_create_augroup("commonAutoGroup", {
  clear = true,
})
local lspAutoGroup = vim.api.nvim_create_augroup("lspAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

local commonFiletypes = { "*.js", "*.jsx", "*.lua", "*.py", "*.rb", "*.rbs", "*.rs", "*.ts", "*.tsx" }
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

-- Auto format before writing to the file
autocmd("BufWritePre", {
  group = lspAutoGroup,
  pattern = commonFiletypes,
  callback = function()
    vim.cmd("FormatWrite")
  end,
})

-- Auto lint after writing to the file
autocmd("BufWritePost", {
  group = lspAutoGroup,
  callback = function()
    require("lint").try_lint()
  end,
})

-- Auto enable parinfer when edit lisp file
autocmd({ "BufEnter", "BufWinEnter" }, {
  group = "commonAutoGroup",
  pattern = lispFiletypes,
  command = "ParinferOn",
})
