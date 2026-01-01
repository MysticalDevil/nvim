-- bufferline configure
-- https://github.com/akinsho/bufferline.nvim#configuration

-- Helper function to get highlight color from theme
local function get_hl_color(group, attr)
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
  if not hl then
    return nil
  end
  local color = hl[attr]
  return color and string.format("#%06x", color) or nil
end

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
      if vim.bo[buf_number].filetype == "qf" then
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

    custom_areas = {
      right = function()
        local result = {}
        local seve = vim.diagnostic.severity
        local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
        local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
        local info = #vim.diagnostic.get(0, { severity = seve.INFO })
        local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

        local error_fg = get_hl_color("DiagnosticError", "fg") or "#EC5241"
        local warn_fg = get_hl_color("DiagnosticWarn", "fg") or "#EFB839"
        local hint_fg = get_hl_color("DiagnosticHint", "fg") or "#A3BA5E"
        local info_fg = get_hl_color("DiagnosticInfo", "fg") or "#7EA9A7"

        if error ~= 0 then
          table.insert(result, { text = (" 󰅚 %s"):format(error), fg = error_fg })
        end

        if warning ~= 0 then
          table.insert(result, { text = ("  %s"):format(warning), fg = warn_fg })
        end

        if hint ~= 0 then
          table.insert(result, { text = ("  %s"):format(hint), fg = hint_fg })
        end

        if info ~= 0 then
          table.insert(result, { text = ("  %s"):format(info), fg = info_fg })
        end
        return result
      end,
    },
    groups = {
      options = {
        toggle_hidden_on_enter = true,
      },
      items = {
        require("bufferline.groups").builtin.pinned:with({ icon = "" }),
      },
    },
  },
}
