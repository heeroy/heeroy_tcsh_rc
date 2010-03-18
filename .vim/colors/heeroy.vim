" heeroy.vim -- heeroy's vim color setting
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "heeroy"
hi Normal       ctermfg=Gray 			guifg=Gray      guibg=black
hi Comment      ctermfg=DarkCyan 		guifg=DarkCyan
hi Constant     ctermfg=Magenta 		guifg=Magenta
hi Special      ctermfg=DarkMagenta 		guifg=DarkMagenta
hi Identifier   ctermfg=LightCyan 		guifg=LightCyan
hi Statement    ctermfg=Yellow 			guifg=Yellow
hi PreProc      ctermfg=LightBlue 		guifg=LightBlue
hi Type         ctermfg=Green 			guifg=Green
hi Function     ctermfg=White 			guifg=White
hi Repeat       ctermfg=White cterm=underline 	guifg=White     gui=underline
hi Operator     ctermfg=Red 			guifg=Red
hi Ignore       ctermfg=Black 			guifg=Black
hi Error        ctermfg=White ctermbg=Red 	guibg=Red       guifg=White
hi Todo         ctermfg=White ctermbg=Blue	guifg=White     guibg=Blue


" Common groups that link to default highlighting.
" You can specify other highlighting easily.
hi link String          Constant
hi link Character       Constant
hi link Number          Constant
hi link Boolean         Constant
hi link Float           Number
hi link Conditional     Repeat
hi link Label           Statement
hi link Keyword         Statement
hi link Exception       Statement
hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc
hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type
hi link Tag             Special
hi link SpecialChar     Special
hi link Delimiter       Special
hi link SpecialComment  Special
hi link Debug           Special
