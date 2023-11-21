local status, comment = pcall(require, "Comment")
if not status then
  vim.notify("Comment not found", "error")
  return
end

local ts_context_commentstring = require("ts_context_commentstring")

local opts = {
  mappings = {
    -- disable extra shortcut key
    extra = false,
  },

  -- Normal mode shortcut key
  toggler = {
    line = "gcc", -- line comment
    block = "gbc", -- block comment
  },
  -- Visual mode
  opleader = {
    line = "gc",
    block = "gb",
  },

  -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
  pre_hook = function(ctx)
    local U = require("Comment.utils")
    -- Determine whether to use linewise or blockwise commentstring
    local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"
    -- Determine the location where to calculate commentstring from
    local location = nil
    if ctx.ctype == U.ctype.blockwise then
      location = ts_context_commentstring.utils.get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.v then
      location = ts_context_commentstring.utils.get_visual_start_location()
    end
    return ts_context_commentstring.internal.calculate_commentstring({
      key = type,
      location = location,
    })
  end,
}

comment.setup(opts)
