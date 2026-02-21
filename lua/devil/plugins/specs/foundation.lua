return {
  -- lazy.nvim
  -- A modern plugin manager for Neovim
  "folke/lazy.nvim",
  -- plenary.nvim
  -- plenary: full; complete; entire; absolute; unqualified.
  -- All the lua functions I don't want to write twice.
  { "nvim-lua/plenary.nvim", lazy = true },
  -- nui.nvim
  -- UI Component Library for Neovim
  { "MunifTanjim/nui.nvim", lazy = true },
  -- sqlite.lua
  -- SQLite LuaJIT binding with a very simple api.
  { "kkharji/sqlite.lua", lazy = true, enabled = vim.uv.os_uname().sysname ~= "Windows_NT" },
  -- mini.icons
  -- Icon provider. Part of 'mini.nvim' library.
  {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  -- nvim-qt
  -- Neovim client library and GUI
  { "equalsraf/neovim-gui-shim", lazy = true },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
}
