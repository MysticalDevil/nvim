local status, tokyonight = pcall(require, 'tokyonight')
if not status then
  vim.notify('toykonight not found')
  return
end

tokyonight.setup({
  style = 'storm',
  transparent = false
})
