local status, colorizer = pcall(require, "colorizer")
if not status then
  vim.notify("nvim-colorizer not found", "error")
  return
end

local opts = {
  "*",
  css = { rgb_fn = true, hls_fn = true },
  html = { names = false, rgb_fn = true, hls_fn = true },
}

colorizer.setup(opts)
