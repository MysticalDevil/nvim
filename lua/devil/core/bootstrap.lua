local notify = require("devil.utils.notify")

-- Auto install lazy.nvim
---@param path string
---@param repository string
---@param branch string
local function bootstrap(path, repository, branch)
  if not vim.uv.fs_stat(path) then
    notify.info(("Bootstrapping %s, please wait..."):format(repository))
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
