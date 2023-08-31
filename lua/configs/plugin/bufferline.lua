local status, bufferline = pcall(require, "bufferline")
if not status then
  vim.notify("bufferline.nvim not found", "error")
  return
end

local utils = require("utils.setup")

local function buf_close()
  require("close_buffers").delete({ type = "this" })
end

-- bufferline configure
-- https://github.com/akinsho/bufferline.nvim#configuration
local opts = {
  options = {
    close_command = buf_close(),
    right_mouse_command = buf_close(),
    -- sidebar configuration
    -- give up the position of neo-tree on the left, show File Explorer
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        text_algin = "left",
      },
    },
    -- use neovim built-in LSP
    diagnostics = "nvim_lsp",
    -- optional, show LSP diagnostic icon
    ---@diagnostic disable-next-line: unused-local
    -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
    diagnostics_indicator = function(_, _, diagnostics_dict, _)
      local s = ""
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and "" or (e == "warning" and "" or "")
        s = s .. n .. sym
      end
      return s
    end,
    custom_areas = {
      right = function()
        local result = {}
        local seve = vim.diagnostic.severity
        local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
        local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
        local info = #vim.diagnostic.get(0, { severity = seve.INFO })
        local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

        if error ~= 0 then
          table.insert(result, { text = "  " .. error, fg = "#EC5241" })
        end

        if warning ~= 0 then
          table.insert(result, { text = "  " .. warning, fg = "#EFB839" })
        end

        if hint ~= 0 then
          table.insert(result, { text = "  " .. hint, fg = "#A3BA5E" })
        end

        if info ~= 0 then
          table.insert(result, { text = "  " .. info, fg = "#7EA9A7" })
        end
        return result
      end,
    },
  },
}
bufferline.setup(opts)

-- left and right tab switching
utils.keymap("n", "<C-h>", "<CMD>BufferLineCyclePrev<CR>")
utils.keymap("n", "<C-l>", "<CMD>BufferLineCycleNext<CR>")
-- close current buffer
utils.keymap("n", "<C-w>", function()
  buf_close()
end)
