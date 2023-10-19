local status, persisted = pcall(require, "persisted")
if not status then
  vim.notify("persistence.nvim not found", "error")
  return
end

local ignore_filetype = {
  "alpha",
  "aerial",
  "neo-tree",
  "nerdtree",
  "NvimTree",
  "dashboard",
  "Trouble",
  "DiffViewFiles",
  "dapui_stacks",
  "dapui_scopes",
  "dapui_watches",
  "dapui_breakpoints",
  "dapui_console",
  "dap-repl",
}

persisted.setup({
  save_dir = vim.fn.expand(("%s/sessions/"):format(vim.fn.stdpath("data"))), -- directory where session files are saved
  silent = false, -- silent nvim message when sourcing session file
  use_git_branch = false, -- create session files based on the branch of the git enabled repository
  autosave = true, -- automatically save session files when exiting Neovim
  should_autosave = function()
    -- do not autosave if the alpha dashboard is the current filetype
    if ignore_filetype[vim.bo.filetype] then
      return false
    end
    return true
  end, -- function to determine if a session should be autosaved
  autoload = false, -- automatically load the session for the cwd on Neovim startup
  on_autoload_no_session = nil, -- function to run when `autoload = true` but there is no session to load
  follow_cwd = true, -- change session file name to match current working directory if it changes
  allowed_dirs = nil, -- table of dirs that the plugin will auto-save and auto-load from
  ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
  telescope = { -- options for the telescope extension
    reset_prompt_after_deletion = true, -- whether to reset prompt after session deleted
  },
})

-- restore the session for the current directory
vim.api.nvim_set_keymap("n", "<leader>ps", [[<cmd>lua require("persisted").load()<cr>]], {})

-- restore the last session
vim.api.nvim_set_keymap("n", "<leader>pl", [[<cmd>lua require("persisted").load({ last = true })<cr>]], {})

-- stop Persistence => session won't be saved on exit
vim.api.nvim_set_keymap("n", "<leader>pd", [[<cmd>lua require("persisted").stop()<cr>]], {})
