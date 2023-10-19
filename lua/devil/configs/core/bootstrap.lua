-- Auto install lazy.nvim
---@param path string
---@param repository string
local function bootstrap(path, repository)
  if not vim.loop.fs_stat(path) then
    vim.notify(("Boostrating %s is being installed, please wait..."):format(repository), vim.log.levels.INFO)
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      ("https://github.com/%s"):format(repository),
      "--branch=stable",
      path,
    })
  end
  vim.opt.rtp:prepend(path)
end

local lazy_path = ("%s/lazy/lazy.nvim"):format(vim.fn.stdpath("data"))
bootstrap(lazy_path, "folke/lazy.nvim")

local nfnl_path = ("%s/lazy/nfnl"):format(vim.fn.stdpath("data"))
bootstrap(nfnl_path, "Olical/nfnl")
