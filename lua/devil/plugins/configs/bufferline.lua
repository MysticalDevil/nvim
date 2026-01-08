-- bufferline configure
-- https://github.com/akinsho/bufferline.nvim#configuration
local excluded_filetypes = {
  ["qf"] = true,
  ["checkhealth"] = true,
  ["gitcommit"] = true,
  ["gitrebase"] = true,
  ["help"] = true,
  ["alpha"] = true,
  ["dashboard"] = true,
  ["neo-tree"] = true,
  ["lazy"] = true,
  ["mason"] = true,
}

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
    middle_mouse_command = function(bufnm)
      require("bufdelete").bufdelete(bufnm, true)
    end,
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
      local icons = {
        error = " ",
        warning = " ",
        info = " ",
        hint = " ",
      }
      local result = {}
      for name, count in pairs(diagnostics_dict) do
        if icons[name] and count > 0 then
          table.insert(result, icons[name] .. count)
        end
      end
      return table.concat(result, " ")
    end,

    custom_filter = function(buf_number)
      if vim.fn.bufname(buf_number) == "" then
        return false
      end
      local ft = vim.bo[buf_number].filetype
      if excluded_filetypes[ft] then
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
            local filename = vim.fn.fnamemodify(name, ":t")

            local excluded_files = {
              ["CMakeLists.txt"] = true,
              ["requirements.txt"] = true,
              ["robots.txt"] = true,
              ["license.txt"] = true,
              ["LICENSE.txt"] = true,
            }

            if excluded_files[filename] then
              return false
            end

            return name:match("%.md") or name:match("%.txt")
          end,
          separator = {
            style = require("bufferline.groups").separator.tab,
          },
        },
        {
          name = "Headers",
          highlight = { sp = "seagreen", underline = false },
          matcher = function(buf)
            return vim.api.nvim_buf_get_name(buf.id):match("%.h$") or vim.api.nvim_buf_get_name(buf.id):match("%.hpp$")
          end,
          separator = {
            style = require("bufferline.groups").separator.tab,
          },
        },
      },
    },
  },
}
