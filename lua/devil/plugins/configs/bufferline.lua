-- bufferline configure
-- https://github.com/akinsho/bufferline.nvim#configuration
return {
  options = {
    mode = "buffers",
    themable = true,
    numbers = function(opts)
      return string.format("%s|%s", opts.id, opts.raise(opts.ordinal))
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
      icon = "▎", -- this should be omitted if indicator style is not 'icon'
      style = "icon",
    },
    buffer_close_icon = "󰅖",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    name_formatter = function(buf) ---@diagnostic disable-line
      -- name                | str        | the basename of the active file
      -- path                | str        | the full path of the active file
      -- bufnr (buffer only) | int        | the number of the active buffer
      -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
      -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    truncate_names = true, -- whether or not tab names should be truncated
    tab_size = 18,
    -- use neovim built-in LSP
    diagnostics = "nvim_lsp",
    -- optional, show LSP diagnostic icon
    ---@diagnostic disable-next-line: unused-local
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = ""
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and "" or (e == "warning" and "" or "")
        s = ("%s%s%s"):format(s, n, sym)
      end
      return s
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number, buf_numbers)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        return true
      end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        return true
      end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        return true
      end
      -- filter out by it's index number in list (don't show first buffer)
      if buf_numbers[1] ~= buf_number then
        return true
      end
    end,
    -- sidebar configuration
    -- give up the position of neo-tree on the left, show File Explorer
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        text_algin = "left",
        separator = true,
      },
    },
    color_icons = true, -- whether or not to add the filetype icon highlights
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
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

        if error ~= 0 then
          table.insert(result, { text = (" 󰅚 %s"):format(error), fg = "#EC5241" })
        end

        if warning ~= 0 then
          table.insert(result, { text = ("  %s"):format(warning), fg = "#EFB839" })
        end

        if hint ~= 0 then
          table.insert(result, { text = ("  %s"):format(hint), fg = "#A3BA5E" })
        end

        if info ~= 0 then
          table.insert(result, { text = ("  %s"):format(info), fg = "#7EA9A7" })
        end
        return result
      end,
    },
    groups = {
      options = {
        toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
      },
      items = {
        --   {
        --     name = "Tests", -- Mandatory
        --     highlight = { underline = true, sp = "blue" }, -- Optional
        --     priority = 2, -- determines where it will appear relative to other groups (Optional)
        --     icon = "", -- Optional
        --     matcher = function(buf) -- Mandatory
        --       return buf.filename:match("%_test") or buf.filename:match("%_spec")
        --     end,
        --   },
        --   {
        --     name = "Docs",
        --     highlight = { undercurl = true, sp = "green" },
        --     auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
        --     matcher = function(buf)
        --       return buf.filename:match("%.md") or buf.filename:match("%.txt")
        --     end,
        --     separator = { -- Optional
        --       style = require("bufferline.groups").separator.tab,
        --     },
        --   },
      },
      require("bufferline.groups").builtin.pinned:with({ icon = "" }),
    },
  },
}
