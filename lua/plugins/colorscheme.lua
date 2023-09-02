return {
  ----------------------------------------- Colorscheme -----------------------------------------
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
  -- onedark.nvim
  -- One dark and light colorscheme for neovim
  {
    "navarasu/onedark.nvim",
    lazy = false,
    proiority = 1000,
    config = function()
      require("configs.colorscheme.onedark")
    end,
  },
  -- onedarkpro.nvim
  --  Atom's iconic One Dark theme, for Neovim. Fully customisable, with Treesitter,
  --  LSP semantic token support and a light variant
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    config = function()
      require("configs.colorscheme.onedarkpro")
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
