local utils = require("dropbar.utils")
local sources = require("dropbar.sources")
local configs = require("dropbar.configs")

local function exculde_filetypes(filetype)
  if filetype:match("^Neogit.*") == nil then
    return true
  end
  return false
end

---@class dropbar_configs_t
return {
  general = {
    ---@type boolean|fun(buf: integer, win: integer): boolean
    enable = function(buf, win)
      return not vim.api.nvim_win_get_config(win).zindex
        and vim.bo[buf].buftype == ""
        and vim.bo[buf].filetype ~= ""
        and exculde_filetypes(vim.bo[buf].filetype)
        and vim.api.nvim_buf_get_name(buf) ~= ""
        and not vim.wo[win].diff
    end,
    attach_events = {
      "OptionSet",
      "BufWinEnter",
      "BufWritePost",
    },
    -- Wait for a short time before updating the winbar, if another update
    -- request is received within this time, the previous request will be
    -- cancelled, this improves the performance when the user is holding
    -- down a key (e.g. 'j') to scroll the window, default to 0 ms
    -- If you encounter performance issues when scrolling the window, try
    -- setting this option to a number slightly larger than
    -- 1000 / key_repeat_rate
    update_interval = 0,
    update_events = {
      win = {
        "CursorMoved",
        "CursorMovedI",
        "WinEnter",
        "WinResized",
      },
      buf = {
        "BufModifiedSet",
        "FileChangedShellPost",
        "TextChanged",
        "TextChangedI",
      },
      global = {
        "DirChanged",
        "VimResized",
      },
    },
  },
  icons = {
    enable = true,
    kinds = {
      use_devicons = true,
      symbols = require("devil.utils").kind_icons,
    },
    ui = {
      bar = {
        separator = " ",
        extends = "…",
      },
      menu = {
        separator = " ",
        indicator = " ",
      },
    },
  },
  symbol = {
    preview = {
      ---Reorient the preview window on previewing a new symbol
      ---@param _ integer source window id, ignored
      ---@param range {start: {line: integer}, end: {line: integer}} 0-indexed
      reorient = function(_, range)
        local invisible = range["end"].line - vim.fn.line("w$") + 1
        if invisible > 0 then
          local view = vim.fn.winsaveview()
          if view ~= nil then
            view.topline = view.topline + invisible
            vim.fn.winrestview(view)
          end
        end
      end,
    },
    jump = {
      ---@param win integer source window id
      ---@param range {start: {line: integer}, end: {line: integer}} 0-indexed
      reorient = function(win, range)
        local view = vim.fn.winsaveview()
        if view ~= nil then
          local win_height = vim.api.nvim_win_get_height(win)
          local topline = range.start.line - math.floor(win_height / 4)
          if topline > view.topline and topline + win_height < vim.fn.line("$") then
            view.topline = topline
            vim.fn.winrestview(view)
          end
        end
      end,
    },
  },
  bar = {
    hover = true,
    sources = function(buf, _)
      if vim.bo[buf].ft == "markdown" then
        return {
          utils.source.fallback({
            sources.treesitter,
            sources.markdown,
            sources.lsp,
          }),
        }
      end
      if vim.bo[buf].buftype == "terminal" then
        return {
          sources.terminal,
        }
      end
      return {
        utils.source.fallback({
          sources.lsp,
          sources.treesitter,
        }),
      }
    end,
    padding = {
      left = 1,
      right = 1,
    },
    pick = {
      pivots = "abcdefghijklmnopqrstuvwxyz",
    },
    truncate = true,
  },
  sources = {
    path = {
      ---@type string|fun(buf: integer, win: integer): string
      relative_to = function(_, win)
        -- Workaround for Vim:E5002: Cannot find window number
        local ok, cwd = pcall(vim.fn.getcwd, win)
        return ok and cwd or vim.fn.getcwd()
      end,
      ---Can be used to filter out files or directories
      ---based on their name
      ---@type fun(name: string): boolean
      filter = function(_)
        return true
      end,
      ---Last symbol from path source when current buf is modified
      modified = function(sym)
        return sym
      end,
    },
    treesitter = {
      -- Lua pattern used to extract a short name from the node text
      -- name_pattern = "[#~%*%w%._%->!@:]+%s*%s" .. string.rep("[#~%*%w%._%->!@:]*", 3, "%s*"),
      -- The order matters! The first match is used as the type
      -- of the treesitter symbol and used to show the icon
      -- Types listed below must have corresponding icons
      -- in the `icons.kinds.symbols` table for the icon to be shown
      valid_types = {
        "array",
        "boolean",
        "break_statement",
        "call",
        "case_statement",
        "class",
        "constant",
        "constructor",
        "continue_statement",
        "delete",
        "do_statement",
        "enum",
        "enum_member",
        "event",
        "for_statement",
        "function",
        "h1_marker",
        "h2_marker",
        "h3_marker",
        "h4_marker",
        "h5_marker",
        "h6_marker",
        "if_statement",
        "interface",
        "keyword",
        "list",
        "macro",
        "method",
        "module",
        "namespace",
        "null",
        "number",
        "operator",
        "package",
        "pair",
        "property",
        "reference",
        "repeat",
        "scope",
        "specifier",
        "string",
        "struct",
        "switch_statement",
        "type",
        "type_parameter",
        "unit",
        "value",
        "variable",
        "while_statement",
        "declaration",
        "field",
        "identifier",
        "object",
        "statement",
        "text",
      },
    },
    lsp = {
      request = {
        -- Times to retry a request before giving up
        ttl_init = 60,
        interval = 1000, -- in ms
      },
    },
    markdown = {
      parse = {
        -- Number of lines to update when cursor moves out of the parsed range
        look_ahead = 200,
      },
    },
    terminal = {
      ---@type string|fun(buf: integer): string
      icon = function(buf)
        local icon = configs.opts.icons.kinds.symbols.Terminal
        if configs.opts.icons.kinds.use_devicons then
          icon = require("nvim-web-devicons").get_icon_by_filetype(vim.bo[buf].filetype) or icon
        end
        return icon
      end,
      ---@type string|fun(buf: integer): string
      name = vim.api.nvim_buf_get_name,
      ---@type boolean
      ---Show the current terminal buffer in the menu
      show_current = true,
    },
  },
}
