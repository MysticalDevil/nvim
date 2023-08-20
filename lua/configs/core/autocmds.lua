local newAutoGroup = vim.api.nvim_create_augroup("newAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

local filetypes = { "*.lua", "*.js", "*.ts", "*.jsx", "*.tsx", "*.rs" }

-- 进入 Terminal 自动进入插入模式
autocmd("TermOpen", {
  group = newAutoGroup,
  command = "startinsert",
})

-- 保存时自动格式化
autocmd("BufWritePre", {
  group = newAutoGroup,
  pattern = filetypes,
  command = "FormatWrite",
})

-- 用 o 换行不要延续注释
autocmd("BufEnter", {
  group = newAutoGroup,
  pattern = "**",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - "o" + "r"
  end,
})

autocmd("BufWinEnter", {
  group = newAutoGroup,
  pattern = filetypes,
  command = "silent! loadview",
})
autocmd("BufWrite", {
  group = newAutoGroup,
  pattern = filetypes,
  command = "mkview",
})
