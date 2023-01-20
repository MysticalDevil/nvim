local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

-- 进入 Terminal 自动进入插入模式
autocmd("TermOpen", {
  group = "myAutoGroup",
  command = "startinsert",
})

-- 保存时自动格式化
autocmd("BufWritePre", {
  group = myAutoGroup,
  pattern = { "*.lua", "*.py", "*.sh" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- 修改 lua/plugins.lua 自动更新插件
autocmd("BufWritePost", {
  group = myAutoGroup,
  callback = function()
    if vim.fn.expand("<afile>") == "lua/configs/core/plugins.lua" then
      vim.api.nvim_command("source lua/configs/core/plugins.lua")
      vim.api.nvim_command("PackerSync")
    end
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = myAutoGroup,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- 用 o 换行不要延续注释
autocmd("BufEnter", {
  group = myAutoGroup,
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - "o" + "r"
  end,
})

-- 保存 Fold
local saveable_type = { "*.lua", "*.js", "*.ts", "*.jsx", "*.tsx", "*.rs" }

autocmd("BufWinEnter", {
  group = myAutoGroup,
  pattern = saveable_type,
  command = "silent! loadview",
})
autocmd("BufWrite", {
  group = myAutoGroup,
  pattern = saveable_type,
  command = "mkview",
})
