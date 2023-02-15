local status, toggleterm = pcall(require, "toggleterm")
if not status then
  vim.notify("toggleterm not found", "error")
  return
end

local opts = {
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.3
    end
  end,
  start_in_insert = true,
}

toggleterm.setup(opts)
