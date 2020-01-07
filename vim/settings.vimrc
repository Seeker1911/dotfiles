" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
" set cursor shapes. line/block/underline
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
set encoding=utf8
"set termencoding=utf-8	       " default terminal encoding
set guifont=Hack\ Nerd\ Font\:h11
set nocompatible	       " required, not vi compatible
set cursorline		       " show cursorline
set mouse=a		       " don't select numbers
set path+=$PWD/**	       " recursivel search directory for files names
set fillchars+=stl:\ ,stlnc:\
set modelines=0		       " fix security exploits
set wildmenu		       " autocomplete command menu
set number		       " show line numbers
set ruler		       " show ruler
set list
set ignorecase		      " ignore caps when searching
set smartcase		      " unless a capital is used
set infercase		      " smart auto-completion casing
set wildignorecase	      " ignore case on files and directories
set lazyredraw
set scrolloff=3
set tags=./tags;/               " ctags read subdirectories
set clipboard=unnamed          " use system clipboard (OS X)
set wrap linebreak nolist      " improved word wrapping
set foldenable                 " enable folding
set undofile
set undodir=~/.vim/undo        " set vims undo directory
set foldlevel=10
set foldnestmax=2
set foldmethod=indent
set nohlsearch
set backup                       " enable backups
set undodir=~/.vim/tmp/undo/     " undo files
set backupdir=~/.vim/tmp/backup/ " backups
set directory=~/.vim/tmp/swap/   " swap files
set noswapfile
set diffopt+=hiddenoff           " no diff on hidden buffer
set diffopt+=iwhiteall           " ignore whitespace on diff
let &colorcolumn="120"
set rtp+=/usr/local/opt/fzf
set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim
set backspace=indent,eol,start
set cmdheight=2 "better display for messages
set updatetime=250 "smaller updatetime for cursorhold, also makes gitgutter more responsive
" suppress the annoying 'match x of y', 'The only match' and 'Pattern not found' messages
set shortmess+=c " don't give |ins-completion-menu| messages.


if has('nvim-0.3.2') || has("patch-8.1.0360")
  set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif

" neovim `terminal` mappings
if has('nvim')
  tnoremap <Esc> <C-\><C-n> "quit built in term
endif



let uname = substitute(system('uname'), '\n', '', '')
if uname == 'Linux'
	let g:python_host_prog = '/home/linuxbrew/.linuxbrew/bin/python'
	let g:python3_host_prog = '/home/michael_mead/.pyenv/versions/neovim3/bin/python'
else "Mac
	let g:python_host_prog = '/Users/meadm1/.pyenv/versions/neovim2/bin/python'
	let g:python3_host_prog = '/Users/meadm1/.pyenv/versions/neovim3/bin/python'
endif
