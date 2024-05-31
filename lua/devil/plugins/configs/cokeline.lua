local get_hex = require("cokeline.hlgroups").get_hl_attr

-- local is_picking_focus = require("cokeline.mappings").is_picking_focus
-- local is_picking_close = require("cokeline.mappings").is_picking_close
local mappings = require("cokeline.mappings")

local red = vim.g.terminal_color_1
local green = vim.g.terminal_color_2
local yellow = vim.g.terminal_color_3

local comments_fg = get_hex("Comment", "fg")
local errors_fg = get_hex("DiagnosticError", "fg")
local warnings_fg = get_hex("DiagnosticWarn", "fg")

-- Start of components table
local components = {
  space = {
    text = " ",
    truncation = { priority = 1 },
  },

  two_spaces = {
    text = "  ",
    truncation = { priority = 1 },
  },

  separator = {
    text = function(buffer)
      return buffer.index ~= 1 and "▏" or ""
    end,
    truncation = { priority = 1 },
  },

  devicon = {
    text = function(buffer)
      return (mappings.is_picking_focus() or mappings.is_picking_close()) and buffer.pick_letter .. " "
        or buffer.devicon.icon
    end,
    fg = function(buffer)
      return (mappings.is_picking_focus() and yellow) or (mappings.is_picking_close() and red) or buffer.devicon.color
    end,
    style = function(_)
      return (mappings.is_picking_focus() or mappings.is_picking_close()) and "italic,bold" or nil
    end,
    truncation = { priority = 1 },
  },

  index = {
    text = function(buffer)
      return buffer.index .. ":" .. buffer.number .. " 󰁎 "
    end,
    truncation = { priority = 1 },
  },

  tabs_index = {
    text = function(buffer)
      if buffer.is_first and buffer.is_last then
        return ""
      end
      return " " .. buffer.index .. " "
    end,
    truncation = { priority = 2 },
    bg = function()
      return get_hex("Normal", "bg")
    end,
  },

  unique_prefix = {
    text = function(buffer)
      return buffer.unique_prefix
    end,
    fg = comments_fg,
    style = "italic",
    truncation = {
      priority = 3,
      direction = "left",
    },
  },

  filename = {
    text = function(buffer)
      return buffer.filename
    end,
    style = function(buffer)
      return ((buffer.is_focused and buffer.diagnostics.errors ~= 0) and "bold,underline")
        or (buffer.is_focused and "bold")
        or (buffer.diagnostics.errors ~= 0 and "underline")
        or nil
    end,
    truncation = {
      priority = 2,
      direction = "left",
    },
  },

  diagnostics = {
    text = function(buffer)
      return (buffer.diagnostics.errors ~= 0 and " 󰅚 " .. buffer.diagnostics.errors)
        or (buffer.diagnostics.warnings ~= 0 and "  " .. buffer.diagnostics.warnings)
        or ""
    end,
    fg = function(buffer)
      return (buffer.diagnostics.errors ~= 0 and errors_fg) or (buffer.diagnostics.warnings ~= 0 and warnings_fg) or nil
    end,
    truncation = { priority = 1 },
  },

  close_or_unsaved = {
    text = function(buffer)
      return buffer.is_modified and "●" or "󰅖"
    end,
    fg = function(buffer)
      return buffer.is_modified and green or nil
    end,
    delete_buffer_on_left_click = true,
    truncation = { priority = 1 },
  },
}

return {
  show_if_buffers_are_at_least = 1,

  buffers = {
    focus_on_delete = "next",
    filter_valid = function(buffer)
      return buffer.filetype ~= "netrw"
    end,
    filter_visible = function(buffer)
      return buffer.filename ~= "netrw"
    end,

    -- If set to `last` new buffers are added to the end of the bufferline,
    -- if `next` they are added next to the current buffer.
    -- if set to `directory` buffers are sorted by their full path.
    -- if set to `number` buffers are sorted by bufnr, as in default Neovim
    -- default: 'last'.
    ---@type 'last' | 'next' | 'directory' | 'number' | fun(a: Buffer, b: Buffer):boolean
    new_buffers_position = "last",

    -- If true, right clicking a buffer will close it
    -- The close button will still work normally
    -- Default: true
    ---@type boolean
    delete_on_right_click = true,
  },

  mappings = {
    -- Controls what happens when the first (last) buffer is focused and you
    -- try to focus/switch the previous (next) buffer. If `true` the last
    -- (first) buffers gets focused/switched, if `false` nothing happens.
    -- default: `true`.
    ---@type boolean
    cycle_prev_next = true,

    -- Disables mouse mappings
    -- default: `false`.
    ---@type boolean
    disable_mouse = false,
  },

  -- Maintains a history of focused buffers using a ringbuffer
  history = {
    ---@type boolean
    enabled = true,
    ---The number of buffers to save in the history
    ---@type integer
    size = 2,
  },

  rendering = {
    -- The maximum number of characters a rendered buffer is allowed to take
    -- up. The buffer will be truncated if its width is bigger than this
    -- value.
    -- default: `999`.
    ---@type integer
    max_buffer_width = 999,
  },

  pick = {
    -- Whether to use the filename's first letter first before
    -- picking a letter from the valid letters list in order.
    -- default: `true`
    ---@type boolean
    use_filename = true,

    -- The list of letters that are valid as pick letters. Sorted by
    -- keyboard reachability by default, but may require tweaking for
    -- non-QWERTY keyboard layouts.
    -- default: `'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERTYQP'`
    ---@type string
    letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERTYQP",
  },

  default_hl = {
    fg = function(buffer)
      return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
    end,
    bg = function()
      return get_hex("ColorColumn", "bg")
    end,
  },
  -- The highlight group used to fill the tabline space
  fill_hl = "TabLineFill",

  components = {
    components.space,
    components.separator,
    components.space,
    components.unique_prefix,
    components.index,
    components.devicon,
    components.filename,
    components.diagnostics,
    components.two_spaces,
    components.close_or_unsaved,
    components.space,
  },

  -- Custom areas can be displayed on the right hand side of the bufferline.
  -- They act identically to buffer components, except their methods don't take a Buffer object.
  -- If you want a rhs component to be stateful, you can wrap it in a closure containing state.
  ---@type Component[] | false
  rhs = {},

  -- Tabpages can be displayed on either the left or right of the bufferline.
  -- They act the same as other components, except they are passed TabPage objects instead of
  -- buffer objects.
  ---@type table | false
  tabs = {
    placement = "right",
    ---@type Component[]
    components = {
      components.tabs_index,
    },
  },

  sidebar = {
    filetype = { "NvimTree", "neo-tree" },
    components = {
      {
        text = function(buf)
          return buf.filetype
        end,
        fg = function()
          return get_hex("WarningMsg", "fg")
        end,
        bg = function()
          return get_hex("NvimTreeNormal", "bg")
        end,
        bold = true,
      },
    },
  },
}
