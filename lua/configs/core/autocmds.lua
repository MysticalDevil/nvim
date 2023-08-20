local commonAutoGroup = vim.api.nvim_create_augroup("commonAutoGroup", {
  clear = true,
})
local formatAutoGroup = vim.api.nvim_create_augroup("formatAutoGroup", {
  clear = true,
})
local lintAutoGroup = vim.api.nvim_create_augroup("lintAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

local filetypes = { "*.lua", "*.js", "*.ts", "*.jsx", "*.tsx", "*.rs" }

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
  group = formatAutoGroup,
  pattern = filetypes,
  command = "FormatWrite",
})

-- Auto lint after writing to the file
autocmd("BufWritePost", {
  group = lintAutoGroup,
  callback = function()
    require("lint").try_lint()
  end,
})
