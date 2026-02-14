---Shared utility helpers.
---@module devil.utils.common

local M = {}
local merge_tb = vim.tbl_deep_extend
local notify = require("devil.utils.notify")

---Print a value via `vim.inspect` and return it unchanged.
---@param v any
---@return any
function M.log(v)
  print(vim.inspect(v))
  return v
end

---Wrapper around `vim.keymap.set` with sane defaults.
---@param mode string|table
---@param lhs string
---@param rhs string|function
---@param opts table?
function M.keymap(mode, lhs, rhs, opts)
  opts = opts or {}
  local default_opts = {
    remap = false,
    silent = true,
  }
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", default_opts, opts))
end

---Serialize nested tables into a flat debug string.
---@param tbl table
---@return string
function M.deep_print(tbl)
  local request_headers_all = ""
  for k, v in pairs(tbl) do
    if type(v) == "table" then
      request_headers_all = ("%s[%s %s]"):format(request_headers_all, k, M.deep_print(v))
    else
      local rowtext = string.format("[%s %s] ", k, v)
      request_headers_all = string.format("%s%s", request_headers_all, rowtext)
    end
  end
  return request_headers_all
end

---Convert mappings.lua section into lazy.nvim key spec format.
---@param name string Plugin name (key in mappings.lua)
---@return table
function M.get_lazy_keys(name)
  local keys = {}
  local mappings = require("devil.core.mappings")

  if not mappings[name] then
    return keys
  end

  local section = mappings[name]
  section.plugin = true

  for mode, mode_values in pairs(section) do
    if mode ~= "plugin" then
      for keybind, mapping_info in pairs(mode_values) do
        local key_config = {
          keybind,
          mapping_info[1],
          desc = mapping_info[2],
          mode = mode,
        }

        if mapping_info.opts then
          for k, v in pairs(mapping_info.opts) do
            key_config[k] = v
          end
        end

        table.insert(keys, key_config)
      end
    end
  end

  return keys
end

---Icon map for LSP and completion kinds.
M.kind_icons = {
  Array = "󰅪 ",
  Boolean = " ",
  BreakStatement = "󰙧 ",
  Call = "󰃷 ",
  CaseStatement = "󱃙 ",
  Class = " ",
  Color = "󰏘 ",
  Constant = "󰏿 ",
  Constructor = " ",
  ContinueStatement = "→ ",
  Copilot = " ",
  Declaration = "󰙠 ",
  Delete = "󰩺 ",
  DoStatement = "󰑖 ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = "󰈙 ",
  Folder = "󰉋 ",
  ForStatement = "󰑖 ",
  Function = "󰊕 ",
  H1Marker = "󰉫 ", -- Used by markdown treesitter parser
  H2Marker = "󰉬 ",
  H3Marker = "󰉭 ",
  H4Marker = "󰉮 ",
  H5Marker = "󰉯 ",
  H6Marker = "󰉰 ",
  Identifier = "󰀫 ",
  IfStatement = "󰇉 ",
  Interface = " ",
  Keyword = "󰌋 ",
  List = "󰅪 ",
  Log = "󰦪 ",
  Lsp = " ",
  Macro = "󰁌 ",
  MarkdownH1 = "󰉫 ", -- Used by builtin markdown source
  MarkdownH2 = "󰉬 ",
  MarkdownH3 = "󰉭 ",
  MarkdownH4 = "󰉮 ",
  MarkdownH5 = "󰉯 ",
  MarkdownH6 = "󰉰 ",
  Method = "󰆧 ",
  Module = "󰏗 ",
  Namespace = "󰌗 ",
  Null = "󰢤 ",
  Number = "󰎠 ",
  Object = "󰅩 ",
  Operator = "󰆕 ",
  Package = "󰆦 ",
  Pair = "󰅪 ",
  Property = " ",
  Reference = "󰦾 ",
  Regex = " ",
  Repeat = "󰑖 ",
  Scope = "󰅩 ",
  Snippet = "󰩫 ",
  Specifier = "󰦪 ",
  Statement = "󰅩 ",
  String = " ",
  Text = "󰉿 ",
  Unit = "󰑭 ",
  Value = "󰎠 ",
  Variable = " ",
  Struct = " ",
  TypeParameter = "󰊄 ",
}

---Filetypes that should be excluded by some UI helpers.
M.exclude_filetypes = {
  "lazy",
  "null-ls-info",
  "dashboard",
  "packer",
  "terminal",
  "help",
  "log",
  "markdown",
  "TelescopePrompt",
  "mason",
  "mason-lspconfig",
  "lspinfo",
  "toggleterm",
  "text",
  "checkhealth",
  "man",
  "gitcommit",
  "TelescopePrompt",
  "TelescopeResults",
}

---Load key mappings from `devil.core.mappings`.
---If `section` is provided, only that section is loaded.
---@param section? string
---@param mapping_opt? table
function M.load_mappings(section, mapping_opt)
  vim.schedule(function()
    local function set_section_map(section_values)
      if section_values.plugin then
        return
      end

      section_values.plugin = nil

      for mode, mode_values in pairs(section_values) do
        local default_opts = merge_tb("force", { mode = mode }, mapping_opt or {})
        for keybind, mapping_info in pairs(mode_values) do
          -- Merge default and per-key options.
          local opts = merge_tb("force", default_opts, mapping_info.opts or {})

          mapping_info.opts, opts.mode = nil, nil
          opts.desc = mapping_info[2]

          vim.keymap.set(mode, keybind, mapping_info[1], opts)
        end
      end
    end

    local mappings = require("devil.core.mappings")

    if type(section) == "string" then
      if not mappings[section] then
        notify.warn(("Keymap Error: '%s' not found in mappings.lua"):format(section))
        return
      end

      mappings[section]["plugin"] = nil
      mappings = { mappings[section] }
    end

    for _, sect in pairs(mappings) do
      set_section_map(sect)
    end
  end)
end

return M
