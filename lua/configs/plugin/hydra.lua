local status, Hydra = pcall(require, "hydra")
if not status then
  vim.notify("hydra.nvim not found", "error")
  return
end

Hydra({
  name = "Side scroll",
  mode = "n",
  body = "z",
  heads = {
    { "h", "5zh" },
    { "l", "5zl", { desc = "←/→" } },
    { "H", "zH" },
    { "L", "zL", { desc = "half screen ←/→" } },
  },
})
