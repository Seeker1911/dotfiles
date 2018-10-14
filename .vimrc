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
Plug 'nightsense/snow'
Plug 'jnurmine/Zenburn'
Plug 'nvie/vim-flake8'
"Plug 'maralla/completor.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'pangloss/vim-javascript'
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
"let g:completor_python_binary = 'usr/bin/python'
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
" ultisnips
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" end plug in specific ---------------------------------------------

" set leader key to comma
let mapleader = ","
filetype on                   " required
hi NonText ctermbg=NONE
highlight PmenuSel ctermbg=5
" save on focus lost
au FocusLost * :wa
" set commands
set nocompatible              " required
set noundofile
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
" set cursor shapes. line/block/underline
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
" maps
map <leader>n :NERDTreeToggle<CR>
" use space to fold/unfold
nnoremap <space> za
" surround word with "
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
" set up proper paste mode and inherit indent from source, then exit paste mode
map <leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
" clear the higlight when hitting return
nnoremap <CR> :nohlsearch<cr>
" remap esc. key to jj
inoremap jj <ESC>
inoremap JJ <ESC>
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" filetype specific settings ----------------------------------------
au BufRead,BufNewFile,BufEnter ~/code/raw-data-repository/* setlocal ts=2 sts=2 sw=2
"function! SetupEnvironment()
"  let l:path = expand('%:p')
"  if l:path =~ '~/code/raw-data-repository'
"    setlocal expandtab smarttab textwidth=0
"    if &filetype == '.py'
"      setlocal tabstop=2 shiftwidth=2 expandtab textwidth=99
"    else
"      setlocal tabstop=4 shiftwidth=4 expandtab textwidth=99
"    endif
"  elseif l:path =~ '~/code/projects'
"    setlocal tabstop=4 shiftwidth=4 noexpandtab
"  endif
"endfunction
"autocmd! BufRead,BufNewFile * call SetupEnvironment()

filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
autocmd!
augroup file_types
	autocmd!
	autocmd FileType python set omnifunc=pythoncomplete#Complete
	" use help command for help files (:h )
	autocmd Filetype python match Error /\s\+$/
	autocmd FileType help setlocal keywordprg=:help
	autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
	autocmd FileType css set omnifunc=csscomplete#CompleteCSS

	" colorschemeiling white space on save, useful for some filetypes ;)
	fun! CleanExtraSpaces()
	    let save_cursor = getpos(".")
	    let old_query = getreg('/')
	    silent! %s/\s\+$//e
	    call setpos('.', save_cursor)
	    call setreg('/', old_query)
	endfun

	if has("autocmd")
	    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
	endif
augroup END

"colorschemes------------------------------------------------------
"let g:solarized_termcolors=256
set t_Co=256
set background=dark
syntax on
set termguicolors "for truecolor support, assuming you have it.
" you may need the below especially with tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" --- nightsense/snow
colorscheme snow
" --- papercolor
" specify options for variant (dark/light) of papercolor theme.
" transparent_background: 1=terminal background 0=theme background
"glet g:PaperColor_Theme_Options = {
"g  \   'theme': {
"g  \     'default.dark': {
"g  \       'transparent_background': 1
"g  \     }
"g  \   }
"g  \ }
"g"Language specific options
"glet g:PaperColor_Theme_Options = {
"g\   'language': {
"g\     'python': {
"g\       'highlight_builtins' : 1
"g\     },
"g\     'cpp': {
"g\       'highlight_standard_library': 1
"g\     },
"g\     'c': {
"g\       'highlight_builtins' : 1
"g\     }
"g\   }
"g\ }
"colorscheme PaperColor

" ------------- vimspectr colorscheme 
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
"colorscheme vimspectrgrey-dark
"colorscheme vimspectrgrey-light
"colorscheme vimspectr60-dark
"colorscheme vimspectr150-dark
