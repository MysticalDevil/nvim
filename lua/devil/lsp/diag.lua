local signs = {
  [vim.diagnostic.severity.ERROR] = "󰅚 ",
  [vim.diagnostic.severity.WARN] = " ",
  [vim.diagnostic.severity.HINT] = "󰌶 ",
  [vim.diagnostic.severity.INFO] = " ",
}

local opts = {
  virtual_text = true,
  virtual_lines = { current_line = true },
  underline = true,
  signs = {
    text = signs,

    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
  },
  update_in_insert = false,
  show_header = false,
  severity_sort = true,
  float = {
    source = "if_many",
    border = "rounded",
    style = "minimal",
    header = "",
    -- prefix = " ",
    -- max_width = 100,
    -- width = 60,
    -- height = 20,
  },
}

vim.diagnostic.config(opts)

---@type integer
local diag_augroup = vim.api.nvim_create_augroup("diagnostic_tweaks", { clear = true })

-- Cache the default virtual_text configuration.
-- Note: This assumes you generally want virtual_text enabled globally.
---@type boolean|vim.diagnostic.Opts.VirtualText|fun(namespace: integer, bufnr:integer)
local default_virt_text = vim.diagnostic.config().virtual_text

-- State flag to track if virtual_text is currently hidden.
---@type boolean
local is_virt_text_hidden = false

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "DiagnosticChanged" }, {
  group = diag_augroup,
  callback = function()
    -- Get current line number (0-indexed for vim.diagnostic.get)
    ---@type integer
    local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1

    -- Get diagnostics for the current line
    ---@type vim.Diagnostic[]
    local diagnostics = vim.diagnostic.get(0, { lnum = lnum })

    ---@type boolean
    local has_diagnostic = not vim.tbl_isempty(diagnostics)

    -- State machine logic: Only update config if the state actually changes.
    -- This significantly reduces API calls and redraw overhead.
    if has_diagnostic and not is_virt_text_hidden then
      -- Diagnostics exist on current line + virtual_text is visible -> Hide it
      vim.diagnostic.config({ virtual_text = false })
      is_virt_text_hidden = true
    elseif not has_diagnostic and is_virt_text_hidden then
      -- No diagnostics on current line + virtual_text is hidden -> Restore it
      vim.diagnostic.config({ virtual_text = default_virt_text })
      is_virt_text_hidden = false
    end
  end,
})

-- Force a diagnostic redraw when exiting Insert mode.
-- Essential when 'update_in_insert = false' is set, ensuring
-- virtual_lines appear immediately upon entering Normal mode.
vim.api.nvim_create_autocmd("InsertLeave", {
  group = diag_augroup,
  callback = function()
    vim.diagnostic.show(nil, 0)
  end,
})
