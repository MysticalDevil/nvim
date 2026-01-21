-- Auto install lazy.nvim
---@param path string
---@param repository string
---@param branch string
local function bootstrap(path, repository, branch)
  if not vim.uv.fs_stat(path) then
    vim.notify(("Boostrating %s is being installed, please wait..."):format(repository), vim.log.levels.INFO)
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      ("https://github.com/%s"):format(repository),
      ("--branch=%s"):format(branch),
      path,
    })
  end
  vim.opt.rtp:prepend(path)
end

local lazy_path = ("%s/lazy/lazy.nvim"):format(vim.fn.stdpath("data"))
bootstrap(lazy_path, "folke/lazy.nvim", "stable")
