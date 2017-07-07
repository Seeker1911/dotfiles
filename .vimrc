set nocompatible              " be iMproved, required
set mouse=a

set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
"set term=xterm-256color
set term=screen-256color
if &term == "screen"
    set t_Co=256
endif
set termencoding=utf-8
set modelines=0 " fix security exploits
set wildmenu " autocomplete
set relativenumber " Numbers lines relative to current line
set undofile " creates .un file with redo actions even after closing
let mapleader = "," " set leader key to comma

" Python specific
" enable syntax highlighting
syntax enable

" show line numbers
set number

" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" set line width to 79
set textwidth=79

" enable all Python syntax highlighting features
let python_highlight_all = 1
" End Python specific

"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS - See more at: https://docs.oseems.com/general/application/vim/auto-complete-javascript#sthash.kpKthHb3.dpuf
filetype plugin on
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" colorscheme
  let g:solarized_termcolors=256
   set t_Co=16
    set background=dark
     "colorscheme solarized
     syntax on

hi NonText ctermbg=NONE

"if filereadable(expand("~/.vimrc.before"))
 " source ~/.vimrc.before
"endif


filetype plugin on
set omnifunc=syntaxcomplete#Complete
set clipboard=unnamed

" lightline status bar. https://github.com/itchyny/lightline.vim
" let g:lightline = {
 "     \ 'colorscheme': 'jellybeans',
 "     \ }

" better word wrapping
set wrap linebreak nolist

" set up proper paste mode and inherit indent from source, then exit paste mode
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"

" clear the higlight when hitting return
:nnoremap <CR> :nohlsearch<cr>

" save on focus lost
au FocusLost * :wa

" remap esc. key to jj
inoremap jj <ESC>
