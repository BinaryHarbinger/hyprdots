" Gruvbox neovim Theme
hi clear
if exists("syntax_on")
  syntax reset
endif
set background=dark
let g:colors_name = "gruvbox"

" Temel renkler
hi Normal       guifg=#EBDBB2 guibg=#282828
hi Comment      guifg=#5f875f gui=italic
hi Constant     guifg=#d7875f
hi Identifier   guifg=#87afd7
hi Statement    guifg=#af5fff gui=bold
hi PreProc      guifg=#ffaf87
hi Type         guifg=#87ffaf
hi Special      guifg=#ff875f
hi Todo         guifg=#ffff00 guibg=#5f0000

" Satır numaraları ve seçim
hi LineNr       guifg=#7C6F64
hi CursorLineNr guifg=#EBDBB2 gui=bold
hi CursorLine   guibg=#504945

