local status, crates = pcall(require, "crates")
if not status then
  vim.notify("crates.nvim not found", "error")
  return
end

local opts = {
  src = {
    coq = {
      enabled = true,
      name = "crates.nvim",
    },
  },
  null_ls = {
    enabled = true,
    name = "crates.nvim",
  },
}
crates.setup(opts)
