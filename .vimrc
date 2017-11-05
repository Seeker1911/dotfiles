" vim-plug  https://github.com/junegunn/vim-plug for docs.
" Specify a directory for plugins
" " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
" Python linting and pep checking
Plug 'w0rp/ale'
" zenburn color schem (add color zenburn to vimrc)
Plug 'jnurmine/Zenburn'
Plug 'nvie/vim-flake8'
Plug 'maralla/completor.vim'
" " Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" " Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" on-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
" " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }
"
" " Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
" " Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
" " Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'
"
" " Initialize plugin system
call plug#end()

" end vim-plug stuff

set nocompatible              " required
filetype off                  " required
" use tab completion in completor vim 
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
set mouse=a
" toggle nerdtree with ctrl+n
map <C-n> :NERDTreeToggle<CR>
" Set this in your vimrc file to disabling highlighting in w0rp/ale
let g:ale_set_highlights = 0
" Set this. Airline will handle the rest in statusline for messages
let g:airline#extensions#ale#enabled = 1
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
"set term=xterm-256color
set term=screen-256color
set t_Co=256
set termencoding=utf-8
set modelines=0 " fix security exploits
set wildmenu " autocomplete command menu
set relativenumber " Numbers lines relative to current line
set undofile " creates .un file with redo actions even after closing
set backupdir=~/.backup
" set leader key to comma
let mapleader = ","

" enable folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
" use space to fold/unfold
nnoremap <space> za

" Python specific
au BufNewFile,BufRead *.py
    \set tabstop=4
    \set softtabstop=4
    \set shiftwidth=4
    \set textwidth=79
    \set expandtab
    \set autoindent
    \set fileformat=unix

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
" set cursorline

" show the matching part of the pair for [] {} and ()
" set showmatch

" set line width to 79
set textwidth=79

" enable all Python syntax highlighting features
let python_highlight_all=1
" End Python specific

"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS - See more at: https://docs.oseems.com/general/application/vim/auto-complete-javascript#sthash.kpKthHb3.dpuf
" The following line isnt needed with vim-plug as it loads this command for you
" filetype plugin on
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


set omnifunc=syntaxcomplete#Complete
" use system clipboard on OSX
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
