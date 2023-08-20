local commonAutoGroup = vim.api.nvim_create_augroup("commonAutoGroup", {
  clear = true,
})
local lspAutoGroup = vim.api.nvim_create_augroup("lspAutoGroup", {
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
  group = lspAutoGroup,
  pattern = filetypes,
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
