vim.opt.guifont = "Fira Code:h14"

vim.cmd([[
" Toggle between normal and fullscreen
" FVimToggleFullScreen
" Cursor tweaks
FVimCursorSmoothMove v:true
FVimCursorSmoothBlink v:true
" Title bar tweaks
FVimCustomTitleBar v:true             " themed with colorscheme
" Debug UI overlay
FVimDrawFPS v:true
" Font tweaks
FVimFontLigature v:true
FVimFontAntialias v:true
FVimFontAutohint v:true
FVimFontSubpixel v:true
FVimFontNoBuiltinSymbols v:false " Disable built-in Nerd font symb
]])
