-- bufferline configure
-- https://github.com/akinsho/bufferline.nvim#configuration

return {
  options = {
    mode = "buffers",
    themable = true,
    numbers = function(opts)
      return string.format("%s", opts.raise(opts.ordinal))
    end,
    close_command = function(bufnum)
      require("bufdelete").bufdelete(bufnum, true)
    end,
    right_mouse_command = function(bufnum)
      require("bufdelete").bufdelete(bufnum, true)
    end,
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    indicator = {
      icon = "▎",
      style = "icon",
    },
    buffer_close_icon = "󰅖",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",

    max_name_length = 18,
    max_prefix_length = 15,
    truncate_names = true,
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(_, _, diagnostics_dict, _)
      local s = ""
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or " ")
        s = ("%s%s%s"):format(s, n, sym)
      end
      return s
    end,

    custom_filter = function(buf_number)
      local ft = vim.bo[buf_number].filetype
      if ft == "qf" or ft == "checkhealth" then
        return false
      end
      if vim.fn.bufname(buf_number) == "" then
        return false
      end
      return true
    end,

    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
        separator = true,
      },
    },
    color_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true,
    persist_buffer_sort = true,
    toggle_hidden_on_enter = true,
    hover = {
      enabled = true,
      delay = 200,
      reveal = { "close" },
    },
    groups = {
      options = {
        toggle_hidden_on_enter = true,
      },
      items = {
        require("bufferline.groups").builtin.pinned:with({ icon = "" }),
        {
          name = "Tests",
          highlight = { underline = true, sp = "blue" },
          priority = 2,
          icon = " ",
          matcher = function(buf)
            local name = vim.api.nvim_buf_get_name(buf.id)
            return name:match("%_test") or name:match("%_spec")
          end,
        },
        {
          name = "Docs",
          highlight = { undercurl = true, sp = "green" },
          auto_close = false,
          matcher = function(buf)
            local name = vim.api.nvim_buf_get_name(buf.id)
            return name:match("%.md") or name:match("%.txt")
          end,
          separator = {
            style = require("bufferline.groups").separator.tab,
          },
        },
      },
    },
  },
}
