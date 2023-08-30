-- Auto install lazy.nvim
---@param path string
---@param repository string
local function bootstrap(path, repository)
  if not vim.loop.fs_stat(path) then
    vim.notify("Boostrating " .. repository .. " is being installed, please wait..", "info")
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/" .. repository,
      "--branch=stable",
      path,
    })
  end
  vim.opt.rtp:prepend(path)
end

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
bootstrap(lazy_path, "folke/lazy.nvim")
