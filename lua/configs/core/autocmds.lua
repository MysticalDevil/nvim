local newAutoGroup = vim.api.nvim_create_augroup("newAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

-- 进入 Terminal 自动进入插入模式
autocmd("TermOpen", {
  group = newAutoGroup,
  command = "startinsert",
})

-- 保存时自动格式化
autocmd("BufWritePre", {
  group = newAutoGroup,
  pattern = { "*.lua", "*.py", "*.sh", "*.rb" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- 修改 lua/plugins.lua 自动更新插件
autocmd("BufWritePost", {
  group = newAutoGroup,
  callback = function()
    if vim.fn.expand("<afile>") == "lua/configs/core/plugins.lua" then
      vim.api.nvim_command("source lua/configs/core/plugins.lua")
      vim.api.nvim_command("LazySync")
    end
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = newAutoGroup,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- 用 o 换行不要延续注释
autocmd("BufEnter", {
  group = newAutoGroup,
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - "o" + "r"
  end,
})

-- 保存 Fold
local saveable_type = { "*.lua", "*.js", "*.ts", "*.jsx", "*.tsx", "*.rs" }

autocmd("BufWinEnter", {
  group = newAutoGroup,
  pattern = saveable_type,
  command = "silent! loadview",
})
autocmd("BufWrite", {
  group = newAutoGroup,
  pattern = saveable_type,
  command = "mkview",
})
