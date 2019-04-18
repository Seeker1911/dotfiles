" vim-plug  https://github.com/junegunn/vim-plug for docs.  install Plugged if
" it doesn't exist
if empty(glob('~/.config/nvim/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.config/nvim/plugged')
" Language Server Protocol (LSP) support for vim & neovim
" see the wiki: https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" Go support : Run :GoInstallBinaries
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'}
" linting and pep checking
Plug 'w0rp/ale'
" Make terminal vim and tmux work better with focus events.
Plug 'tmux-plugins/vim-tmux-focus-events'
" color schemes
Plug 'nightsense/vimspectr'
Plug 'nightsense/snow'
Plug 'nightsense/carbonized'
Plug 'morhetz/gruvbox'
Plug 'ajmwagar/vim-deus'
Plug 'daylerees/colour-schemes', { 'rtp': 'vim/' }
Plug 'jnurmine/Zenburn'
Plug 'NLKNguyen/papercolor-theme'
" fix colorscheme problems
Plug 'godlygeek/csapprox'
" on-demand loading of nerdtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" git in vim
Plug 'tpope/vim-fugitive'
" language pack
Plug 'sheerun/vim-polyglot'
" fuzzy finder everywhere
Plug 'junegunn/fzf.vim'
" see xterm color table
Plug 'guns/xterm-color-table.vim'
Plug 'airblade/vim-gitgutter'
Plug 'simnalamburt/vim-mundo'
" plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" distraction free writing
Plug 'junegunn/goyo.vim'
" automatically update tags files that have had 'ctags -R' performed
Plug 'craigemery/vim-autotag'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rhysd/devdocs.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'ryanoasis/vim-devicons'
"Plug 'edkolev/tmuxline.vim'
" using a non-master branch
" plug 'name/repo', { 'branch': 'stable' }
" " using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" plug 'name/repo', { 'tag': 'v.20150303', 'rtp': 'vim' }
call plug#end()

" maps -----------------------------------------------------
let mapleader = ","	       " set mapleader
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
inoremap jj <ESC>
inoremap JJ <ESC>
" open files with RG.
map <leader>n :NERDTreeToggle<CR>
" Adjust viewports to the same size
map <Leader>= <C-w>=
map <leader>m :MundoToggle<CR>
" set up proper paste mode and inherit indent from source, then exit paste mode
map <leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
" ripgrep is controlled by Coc.nvim but must still be installed seperately.
map <leader>f :Rg<CR>
"buffers from fzf (start typing to filter list)
map <leader>b :Buffers<CR>
" surround word with "
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
" clear the higlight when hitting return
nnoremap <nowait> <silent> <leader>h :set hlsearch<cr>
nnoremap <nowait> <silent> <leader>nh :set nohlsearch<cr>
" use space to fold/unfold
nnoremap <space> za
" open all folds
nnoremap <leader>r zR
" close all folds
nnoremap <leader>z zM
"split navigations, doesn't work with tmux.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap ; :Files<CR>
" resize vim windows
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap ]q :cnext
nnoremap [q :cprevious
nnoremap ]l :lnext
nnoremap [l :lprevious
nnoremap <leader>c <Plug>(devdocs-under-cursor)
nnoremap <leader> <silent>K :call CocAction('doHover')<CR>
" Use S for show documentation in preview window
nnoremap <silent>S :call <SID>show_documentation()<CR>
" fugitive bindings
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gc :Gcommit -v<cr>
nnoremap <leader>gD :Gdiff<cr>
nnoremap <leader>gl :Git log<cr>
nnoremap <leader>gL :Git log -p<cr>
nnoremap <leader>gr :Grebase -i --autosquash
nnoremap <leader>gf :GFiles -co --exclude-per-directory=.gitignore<CR>
" Remap keys for COC
nmap <leader>gd <plug>(coc-definition)
nmap <leader>gt <plug>(coc-type-definition)
nmap <leader>gm <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <silent> [c <Plug>(coc-diagnostic-previous)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
nmap <buffer> <F3> <plug>(coc-rename)
nmap <F4> <plug>(coc-format)
nmap <F5> <plug>(coc-fix-current)
nmap <F6> <plug>(coc-diagnostic-info)
vmap <leader>f  <Plug>(coc-format-selected)
" set cursor shapes. line/block/underline
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
let NERDTreeDirArrowExpandable = "\u00a0" " make arrows invisible
let NERDTreeDirArrowCollapsible = "\u00a0" " make arrows invisible
"devdocs
let g:devdocs_host = 'localhost:9292'

" Ale settings
let g:ale_set_highlights = 1
let g:ale_set_signs = 1

" todo: get symbols
"let g:ale_sign_error = 
"let g:ale_sign_warning = 
"let g:ale_sign_info = 
"let g:ale_sign_style_error = 
"let g:ale_sign_style_warning = 
let g:ale_python_pylint_options = '--rcfile /Users/meadm1/code/raw-data-repository/rdr_client/venv/bin/pylint'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = 'ALE: [%linter%] %s [%severity%]'
let b:ale_linters = {
      \  'python': ['pyflakes', 'flake9', 'pylint'],
      \  'sh': ['language_server']
      \}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'python': ['autopep8']
\}
let g:flake8_show_in_gutter=1
let g:ale_python_flake8_global = 1

" end plug in specific -------------------------------------------------------

" set preferred defaults ------------------------------------------------------
filetype on                    " required
hi NonText ctermbg=NONE
highlight PmenuSel ctermbg=5
"syntax enable		       " enable syntax highlighting
set encoding=utf8
set termencoding=utf-8	       " default terminal encoding
set guifont=Hack\ Nerd\ Font\:h11
let g:airline_powerline_fonts = 1
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
set noswapfile                " don't make swapfiles
set ignorecase		      " ignore caps when searching
set smartcase		      " unless a capital is used
set infercase		      " smart auto-completion casing
set wildignorecase	      " ignore case on files and directories
set lazyredraw
set scrolloff=3
set tags=tags;/               " ctags read subdirectories
set clipboard=unnamed          " use system clipboard (OS X)
set wrap linebreak nolist      " improved word wrapping
set foldenable                 " enable folding
set undofile
set undodir=~/.vim/undo        " set vims undo directory
set foldlevel=1
"set foldlevelstart=10
set foldnestmax=2
set foldmethod=indent
set nohlsearch                     "highlight searches
set backup                       " enable backups
set undodir=~/.vim/tmp/undo/     " undo files
set backupdir=~/.vim/tmp/backup/ " backups
set directory=~/.vim/tmp/swap/   " swap files
" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
" highlight line 80 and 120+
highlight ColorColumn ctermbg=232
"let &colorcolumn="100,".join(range(120,999),",")
let &colorcolumn="100"


if glob('/Users/meadm1')
  let g:python_host_prog = '/Users/meadm1/.pyenv/versions/neovim2/bin/python'
  let g:python3_host_prog = '/Users/meadm1/.pyenv/versions/neovim3/bin/python'
elseif glob('/home/michael_mead')
  let g:python_host_prog = '/home/michael_mead/.pyenv/versions/neovim2/bin/python'
  let g:python3_host_prog = '/home/michael_mead/.pyenv/versions/neovim3/bin/python'
endif

" save on focus lost
au FocusLost * :wa "Dont need this and below necessarily.
" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
au FocusLost,WinLeave * :silent! wa

" Trigger autoread when changing buffers or coming back to vim.
au FocusGained,BufEnter * :silent! !

" filetype specific settings ----------------------------------------
au BufRead,BufNewFile,BufEnter ~/code/raw-data-repository/* setlocal ts=2 sts=2 sw=2

" call flake8 on write, default is F-7 to run manually
autocmd BufWritePost *.py call Flake8()
au! FileType {.py} nn <silent> <buffer> gd :call CocAction("jumpDefinition")<CR>
autocmd CursorHoldI,CursorMovedI * call CocAction('showSignatureHelp')

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
set t_Co=257
set background=dark
syntax on
set termguicolors "for truecolor support, assuming you have it.
" you may need the below especially with tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let g:gruvbox_contrast_dark="soft"
let g:gruvbox_contrast_light="hard"
let g:gruvbox_improved_strings=0
let g:gruvbox_improved_warnings=1
let g:gruvbox_termcolors=256
colorscheme gruvbox
" Airline and tmuxline ---------------------------------------------------
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
let g:airline_theme='distinguished'

" use Gruvbox theme for fzf colors
let g:fzf_colors = {
  \ 'fg':      ['fg', 'GruvboxGray'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'GruvboxRed'],
  \ 'fg+':     ['fg', 'GruvboxGreen'],
  \ 'bg+':     ['bg', 'GruvboxBg1'],
  \ 'hl+':     ['fg', 'GruvboxRed'],
  \ 'info':    ['fg', 'GruvboxOrange'],
  \ 'prompt':  ['fg', 'GruvboxBlue'],
  \ 'header':  ['fg', 'GruvboxBlue'],
  \ 'pointer': ['fg', 'Error'],
  \ 'marker':  ['fg', 'Error'],
  \ 'spinner': ['fg', 'Statement'],
  \ }

" functions -----------------------------------------------------
function! ProseMode()
  call goyo#execute(0, [])
  set spell noci nosi noai nolist noshowmode noshowcmd
  set complete+=s
  set bg=light
  if !has('gui_running')
    let g:solarized_termcolors=256
  endif
  colors vimspectrgrey-light
endfunction
command! ProseMode call ProseMode()
nmap \p :ProseMode<CR>

" start point for auto installing coc-extensions (WIP)
let s:coc_extensions = [
\   'coc-css',
\   'coc-html',
\   'coc-json',
\   'coc-eslint',
\   'coc-prettier',
\   'coc-tsserver',
\   'coc-pyls',
\   'coc-yaml'
\ ]

if exists('*coc#add_extension')
  call call('coc#add_extension', s:coc_extensions)
endif

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


function! LightSide()
  colors snow
  set background=light
endfunction
command! LightSide call LightSide()
nmap <leader>l :LightSide<CR>

function! DarkSide()
  colors gruvbox
  set background=dark
endfunction
command! DarkSide call DarkSide()
nmap <leader>d :DarkSide<CR>

