local status, ufo = pcall(require, "ufo")
if not status then
  vim.notify("nvim-ufo not found", "error")
  return
end

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" 󰁂 %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

ufo.setup({
  open_fold_hl_timeout = 400,
  provider_selector = function() -- (bufnr, filetype, buftype)
    return { "treesitter", "indent" }
  end,
  close_fold_kinds = {},
  enable_get_fold_virt_text = false,
  preview = {
    win_config = {
      border = "rounded",
      winblend = 12,
      winhighlight = "Normal:Normal",
      maxheight = 20,
    },
  },
  -- global handler
  -- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
  -- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
  fold_virt_text_handler = handler,
})
