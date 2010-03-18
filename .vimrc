" heeroy's vimrc
let Tlist_Ctags_Cmd="/usr/bin/ctags"
let Tlist_Inc_Winwidth = 0
let Tlist_GainFocus_On_ToggleOpen = 1

" setting auto complete function for different language
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

set wildmenu
set backspace=2
set cindent
set cmdheight=2
set nocompatible
" 20080123 vim utf8 settings
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,big5,latin1,euc-jp,gbk,euc-kr,iso8859-1
set fileencoding=utf-8
set termencoding=utf-8
" {{{ UTF-8 Big5 Setting
" 以下四個設下去. vim 編出來都是 big5 編碼的.
" set fileencodings=big5,utf-8
" 檔案存檔會存成 big5 編碼
" set fileencodings=ucs-bom,utf-8,big5,latin1,euc-jp,gbk,euc-kr,iso8859-1
" set enc=big5
" set tenc=big5
" }}}
set guifontset=8x16,kc15f,-*-16-*-big5-0 "for UNIX setting
" set guifont=細明體:h15:w7::cCHINESEBIG5 "for Windows setting
set linebreak
set hlsearch
set ignorecase
set number
set nomodeline
set nopaste
set hlsearch
set incsearch
set pastetoggle=<f5>
set shiftwidth=4
set softtabstop=4
set tabstop=4
set backspace=indent,eol,start
set ruler
set t_Co=256
set ambiwidth=double
set expandtab
syn on
colorscheme heeroy
" for python syntax
"colorscheme wombat256
let python_highlight_all = 1
autocmd BufRead,BufNewFile *.py syntax on
autocmd BufRead,BufNewFile *.py set ai
autocmd BufRead,BufNewFile *.py set foldmethod=indent
"autocmd BufRead,BufNewFile *.py set foldmethod=marker
autocmd BufRead,BufNewFile *.py set syntax=python
autocmd BufRead,BufNewFile *.py set smartindent
autocmd BufRead,BufNewFile *.py set cinwords=class,def,elif,else,except,finally,for,if,try,while
autocmd FileType * set tabstop=2|set shiftwidth=2|set noexpandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
" when open a file, cusor will start at last edit line
autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif
" set cursorline
" highlight cursorline ctermfg=White ctermbg=Blue
map Q  :q!<CR>
map tc :tabnew<CR>
map td :tabclose<CR>
map tn :tabnext<CR>
map th :tabprev<CR>
"map <f6> :let &tenc=&enc<CR>:set enc=big5<CR>:set tenc=utf-8<CR>
"map <f7> :set termencoding=big5<CR>:set enc=big5<CR>:set tenc=big5<CR>

" set number keyboard enable
:imap <Esc>Oq 1
:imap <Esc>Or 2
:imap <Esc>Os 3
:imap <Esc>Ot 4
:imap <Esc>Ou 5
:imap <Esc>Ov 6
:imap <Esc>Ow 7
:imap <Esc>Ox 8
:imap <Esc>Oy 9
:imap <Esc>Op 0
:imap <Esc>On .
:imap <Esc>OQ /
:imap <Esc>OR *
:imap <Esc>Ol +
:imap <Esc>OS -
:imap <Esc>OM <C-M>

highlight Comment ctermfg=darkcyan
" highlight Search term=reverse ctermbg=LightBlue ctermfg=White
highlight Search ctermbg=4 ctermfg=7


"" heeroy.vim -- heeroy's vim color setting
"set background=dark
"hi clear
"if exists("syntax_on")
"  syntax reset
"endif
"" let g:colors_name = "heeroy"
"hi Normal       ctermfg=Gray 			guifg=Gray      guibg=black
"hi Comment      ctermfg=DarkCyan 		guifg=DarkCyan
"hi Constant     ctermfg=Magenta 		guifg=Magenta
"hi Special      ctermfg=DarkMagenta 		guifg=DarkMagenta
"hi Identifier   ctermfg=LightCyan 		guifg=LightCyan
"hi Statement    ctermfg=Yellow 			guifg=Yellow
"hi PreProc      ctermfg=LightBlue 		guifg=LightBlue
"hi Type         ctermfg=Green 			guifg=Green
"hi Function     ctermfg=White 			guifg=White
"hi Repeat       ctermfg=White cterm=underline 	guifg=White     gui=underline
"hi Operator     ctermfg=Red 			guifg=Red
"hi Ignore       ctermfg=Black 			guifg=Black
"hi Error        ctermfg=White ctermbg=Red 	guibg=Red       guifg=White
"hi Todo         ctermfg=White ctermbg=Blue	guifg=White     guibg=Blue
"
"
"" Common groups that link to default highlighting.
"" You can specify other highlighting easily.
"hi link String          Constant
"hi link Character       Constant
"hi link Number          Constant
"hi link Boolean         Constant
"hi link Float           Number
"hi link Conditional     Repeat
"hi link Label           Statement
"hi link Keyword         Statement
"hi link Exception       Statement
"hi link Include         PreProc
"hi link Define          PreProc
"hi link Macro           PreProc
"hi link PreCondit       PreProc
"hi link StorageClass    Type
"hi link Structure       Type
"hi link Typedef         Type
"hi link Tag             Special
"hi link SpecialChar     Special
"hi link Delimiter       Special
"hi link SpecialComment  Special
"hi link Debug           Special
