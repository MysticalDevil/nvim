local status, dotenv = pcall(require, "dotenv")
if not status then
  vim.notify("dotenv not found")
  return
end

local opts = {
  enable_on_load = true,
  verbose = false,
}

dotenv.setup(opts)
