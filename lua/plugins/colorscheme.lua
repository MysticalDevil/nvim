return {
  ----------------------------------------- Colorscheme -----------------------------------------
  -- aurora
  -- A vivid dark theme for (Neo)Vim. Optimized for treesitter, LSP.
  { "ray-x/aurora", lazy = true },
  -- catppuccin
  -- Soothing pastel theme for (Neo)vim
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    config = function()
      require("configs.colorscheme.catppuccin")
    end,
  },
  -- doom-one.nvim
  -- doom-emacs' doom-one Lua port for Neovim
  { "NTBBloodbath/doom-one.nvim", lazy = true },
  -- dracula.nvim
  -- Dracula colorscheme for neovim written in Lua
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.dracula")
    end,
  },
  -- Everblush
  -- A port of everblush.vim but written in lua
  {
    "Everblush/nvim",
    as = "everblush",
    lazy = true,
    config = function()
      require("configs.colorscheme.everblush")
    end,
  },
  -- github-nvim-theme
  -- Github's Neovim themes
  {
    "projekt0n/github-nvim-theme",
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    config = function()
      require("configs.colorscheme.github-theme")
    end,
  },
  -- gruvbox.nvim
  -- Lua port of the most famous vim colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.gruvbox")
    end,
  },
  -- kanagawa.nvim
  -- NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.kanagawa")
    end,
  },
  -- material.nvim
  -- Material colorscheme for NeoVim
  {
    "marko-cerovac/material.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.material")
    end,
  },
  -- nightfox.nvim
  -- A highly customizable theme for vim and neovim with support for lsp, treesitter and a variety of plugins.
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.nightfox")
    end,
  },
  -- nord.nvim
  -- An arctic, north-bluish clean and elegant Neovim theme.
  {
    "gbprod/nord.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.nord")
    end,
  },
  -- nordic.nvim
  --  Nord for Neovim, but warmer and darker. Supports a variety of plugins and other platforms.
  {
    "AlexvZyl/nordic.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.nordic")
    end,
  },
  -- nyoom.nvim
  -- A Neovim framework and doom emacs alternative for the stubborn martian hacker. Powered by fennel and the oxocarbon theme
  { "nyoom-engineering/nyoom.nvim", lazy = true },
  -- onedark.nvim
  -- One dark and light colorscheme for neovim
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("configs.colorscheme.onedark")
    end,
  },
  -- poimandres.nvim
  -- Poimandres colorscheme for Neovim written in Lua
  {
    "olivercederborg/poimandres.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.poimandres")
    end,

    -- optionally set the colorscheme within lazy config
    init = function()
      vim.cmd("colorscheme poimandres")
    end,
  },
  -- tokyonight.nvim
  -- A clean, dark Neovim theme written in Lua
  {
    "folke/tokyonight.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.tokyonight")
    end,
  },
}
