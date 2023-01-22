local status, beacon = pcall(require, "beacon")
if not status then
  vim.notify("beacon.nvim not found")
  return
end

local opts = {
  enable = true,
  size = 40,
  fade = true,
  minimal_jump = 10,
  show_jumps = true,
  focus_gained = false,
  shrink = true,
  timeout = 500,
  ignore_buffers = {},
  ignore_filetypes = {},
}

beacon.setup(opts)
