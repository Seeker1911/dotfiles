" vim-plug  https://github.com/junegunn/vim-plug for docs.
" Specify a directory for plugins
" " - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
" Python linting and pep checking
Plug 'w0rp/ale'
" zenburn color schem (add color zenburn to vimrc)
Plug 'nightsense/vimspectr'
Plug 'jnurmine/Zenburn'
Plug 'nvie/vim-flake8'
Plug 'maralla/completor.vim'
" fix colorscheme problems 
Plug 'godlygeek/csapprox'
" " Any valid git URL is allowed
" " Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" on-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" git in vim
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
" fuzzy finder everywhere
Plug 'junegunn/fzf.vim'
" grep search everywhere.
Plug 'mhinz/vim-grepper'
" see xterm color table 
Plug 'guns/xterm-color-table.vim'
Plug 'airblade/vim-gitgutter'
Plug 'simnalamburt/vim-mundo'
" automatically update tags files that have had 'ctags -R' performed
Plug 'craigemery/vim-autotag'
" using a non-master branch
" plug 'rdnetto/ycm-generator', { 'branch': 'stable' }
"
" " using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" plug 'fatih/vim-go', { 'tag': '*' }
"
" " plugin options
" plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
" " plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
" " unmanaged plugin (manually installed and updated)
" plug '~/my-prototype-plugin'
"
" " initialize plugin system
call plug#end()

" use tab _tompletion in completor vim 
let g:completor_python_binary = 'usr/bin/python'
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" Set this in your vimrc file to disabling highlighting in w0rp/ale
let g:ale_set_highlights = 0
" use flake8 from virtualenv if it exists.
let g:ale_python_flake8_glabal = 1
" Set this. Airline will handle the rest in statusline for messages
let g:airline#extensions#ale#enabled = 1
" lint
let g:ale_python_pylint_options = '--rcfile /Users/meadm1/code/raw-data-repository/rdr_client/venv/bin/pylint'

" end plug in specific ---------------------------------------------

" set commands for preferred general settings ---------------------

" set leader key to comma
let mapleader = ","
" toggle nerdtree with ctrl+n
map <leader> :NERDTreeToggle<CR>
filetype on                   " required
set nocompatible              " required
" dont select numbers in selection
set mouse=a
" recursively search in working directory for file names. 
set path+=$PWD/** 
set encoding=utf-8
set termencoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set modelines=0 " fix security exploits
set wildmenu " autocomplete command menu
set backupdir=~/.backup
" enable syntax highlighting
syntax enable
" show line numbers
set number
set ruler
set list
set noswapfile
set ignorecase      "ignore caps when searching
set smartcase       "unless a capital is used
set infercase       "smart auto-completion casing
set wildignorecase  "ignore case on files and directories
set lazyredraw
set scrolloff=3
" ensure ctags can read subdirectories
set tags=tags;/
hi NonText ctermbg=NONE
highlight PmenuSel ctermbg=5
set omnifunc=syntaxcomplete#Complete
" use system clipboard on OSX
set clipboard=unnamed
" better word wrapping
set wrap linebreak nolist
" enable folding
set foldenable
set undodir=~/.backup
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
set hlsearch
" use space to fold/unfold
nnoremap <space> za
" set up proper paste mode and inherit indent from source, then exit paste mode
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
" clear the higlight when hitting return
nnoremap <CR> :nohlsearch<cr>
" save on focus lost
au FocusLost * :wa
" remap esc. key to jj
inoremap jj <ESC>
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Python specific -------------------------------------------
" au BufNewFile,BufRead *.py
"au FileType python 
"    \set tabstop=2
"    \set softtabstop=2
"    \set shiftwidth=2
"    \set textwidth=80
"    \set expandtab
"    \set autoindent
"    \set fileformat=unix

"" enable all Python syntax highlighting features
"let python_highlight_all=1
"" indent when moving to the next line while writing code
"set autoindent
"" set tabs to have 2 spaces
"set ts=2
"" set soft tabstop
"set sts=2
"" expand tabs into spaces
"set expandtab
"" when using the >> or << commands, shift lines by 2 spaces
"set shiftwidth=2
"" show a visual line under the cursor's current line
"set cursorline
"" show the matching part of the pair for [] {} and ()
"set showmatch
"" set line width to 99
"set textwidth=99

" End Python specific

" filetype specific settings ----------------------------------------
filetype plugin indent on
"autocmd FileType python set omnifunc=pythoncomplete#Complete
" use help command for help files (:h )
autocmd Filetype python match Error /\s\+$/
autocmd FileType help setlocal keywordprg=:help
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" colorscheme ------------------------------------------------------
"let g:solarized_termcolors=256
set t_Co=256
set background=dark
syntax on

" vimspectr methods
" https://github.com/nightsense/vimspectr
" colorscheme vimspectrHS-B H=hue, S=saturation, B=background
" vimspectr carbonized
" let g:vimspectr60flat_dark_StatusLine = 'orange'
" my default dark theme.
"simplify light theme"
"colorscheme vimspectrgrey-light
" carbonized
"let g:vimspectr60flat_dark_StatusLine = 'orange'
"colorscheme vimspectr60flat-dark 
" forgotten
"let g:vimspectr210curve_dark_StatusLine = 'red'
"colorscheme vimspectr210curve-dark 
" office
"colorscheme vimspectr60flat-dark 
colorscheme vimspectrgrey-dark
"colorscheme vimspectrgrey-light
"colorscheme vimspectr60-dark  
"

