" Binary Harbinger neovim Theme
hi clear
if exists("syntax_on")
  syntax reset
endif

set background=dark
let g:colors_name = "akaiyama"

hi Normal       guifg=#FFCACA guibg=#414447
hi Comment      guifg=#5f875f gui=italic
hi Constant     guifg=#d7875f
hi Identifier   guifg=#87afd7
hi Statement    guifg=#af5fff gui=bold
hi PreProc      guifg=#ffaf87
hi Type         guifg=#87ffaf
hi Special      guifg=#ff875f
hi Todo         guifg=#ffff00 guibg=#5F0000
hi Visual       guibg=#767A7C guifg=#FFCACA 

hi LineNr       guifg=#414447
hi CursorLineNr guifg=#FFCACA gui=bold
hi CursorLine   guibg=#464A4C
