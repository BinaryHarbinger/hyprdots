" Windoes neovim Theme
hi clear
if exists("syntax_on")
  syntax reset
endif
set background=dark
let g:colors_name = "windoes"

hi Normal       guifg=#FFFFFF guibg=#101010
hi Comment      guifg=#5f875f gui=italic
hi Constant     guifg=#d7875f
hi Identifier   guifg=#87afd7
hi Statement    guifg=#af5fff gui=bold
hi PreProc      guifg=#ffaf87
hi Type         guifg=#87ffaf
hi Special      guifg=#ff875f
hi Todo         guifg=#ffff00 guibg=#5f0000

hi LineNr       guifg=#2D2D40
hi CursorLineNr guifg=#FFFFFF gui=bold
hi CursorLine   guibg=#2a2a2a

