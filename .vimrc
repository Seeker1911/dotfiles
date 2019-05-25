if empty(glob('~/.config/nvim/plug.vim'))
      silent !curl -fLo ~/.config/nvim/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.config/nvim/plugged')
      Plug 'w0rp/ale'
      Plug 'nightsense/snow', {'on': 'LightSide'}
      Plug 'davidhalter/jedi-vim'
      Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'}
      Plug 'tmux-plugins/vim-tmux-focus-events'
      Plug 'morhetz/gruvbox'
      Plug 'godlygeek/csapprox'
      Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
      Plug 'guns/xterm-color-table.vim'
      Plug 'airblade/vim-gitgutter'
      Plug 'simnalamburt/vim-mundo'
      Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
      Plug 'junegunn/fzf.vim'
      Plug 'craigemery/vim-autotag'
      Plug 'vim-airline/vim-airline'
      Plug 'vim-airline/vim-airline-themes'
      Plug 'jremmen/vim-ripgrep'
      Plug 'ryanoasis/vim-devicons'
call plug#end()

filetype plugin indent on
hi NonText ctermbg=NONE
highlight PmenuSel ctermbg=5
highlight ColorColumn ctermbg=232

let mapleader = ","
let maplocalleader = "\\"
vmap <leader>c :s/^/#/g<CR>
vmap <leader>" :s/^/"/g<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
inoremap jj <ESC>
inoremap JJ <ESC>
map <leader>t :NERDTreeToggle<CR>
" Adjust viewports to the same size
map <Leader>= <C-w>=
map <leader>m :MundoToggle<CR>
map <leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
" ripgrep fzf find word under cursor in nearby files.
map <leader>F :Rg<CR>
map <leader>f :Files<CR>
map <leader>b :Buffers<CR>
nmap <leader>l :LightSide<CR>
nmap <leader>d :DarkSide<CR>
" surround word with "
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <nowait> <silent> <leader>h :set hlsearch<cr>
nnoremap <nowait> <silent> <leader>nh :set nohlsearch<cr>
" use space to fold/unfold
nnoremap <space> za
" open all folds
nnoremap <leader>zr zR
" close all folds
nnoremap <leader>zm zM
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap ]c :cnext
nnoremap [c :cprevious
nnoremap ]l :lnext
nnoremap [l :lprevious
nnoremap <silent>S :call <SID>show_documentation()<CR>
nnoremap <leader>print oprint('\n')<CR>print('**********************')<CR>print(), '<<<<'<CR>print('**********************')<ESC>k^wa
nnoremap <leader>i oimport ipdb; ipdb.set_trace()<ESC>
nnoremap <silent> <c-u> :call <sid>smoothScroll(1)<cr>
nnoremap <silent> <c-d> :call <sid>smoothScroll(0)<cr>

" set cursor shapes. line/block/underline
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

set encoding=utf8
set termencoding=utf-8	       " default terminal encoding
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
set diffopt+=hiddenoff           " no diff on hidden buffer
set diffopt+=iwhiteall           " ignore whitespace on diff
let &colorcolumn="100"
set rtp+=/usr/local/opt/fzf
set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim
set backspace=indent,eol,start

if glob('/Users/meadm1')
    let g:python_host_prog = '/Users/meadm1/.pyenv/versions/neovim2/bin/python'
    let g:python3_host_prog = '/Users/meadm1/.pyenv/versions/neovim3/bin/python'
elseif glob('/home/michael_mead')
    let g:python_host_prog = '/home/michael_mead/.pyenv/versions/neovim2/bin/python'
    let g:python3_host_prog = '/home/michael_mead/.pyenv/versions/neovim3/bin/python'
endif

function! LightSide()
    colors snow
    set background=light
    let g:airline_theme='snow_light'
    endfunction
command! LightSide call LightSide()

function! DarkSide()
    colors gruvbox
    set background=dark
    endfunction
command! DarkSide call DarkSide()

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

" Make these folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Jedi settings
autocmd FileType python setlocal completeopt-=preview
" 1= buffer, 2=commmandline (better under history)
let g:jedi#show_call_signatures = "1"
let g:jedi#popup_select_first = 0
"defaults, here for reference.
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<TAB>"
let g:jedi#rename_command = "<leader>r"

" Ale settings
let g:ale_completion_enabled = 1
let g:ale_python_pylint_use_global = 1
let g:ale_python_flake8_global = 1
"let g:ale_python_pylint_options = "--init-hook='import sys;
"sys.path.append(\'.\')'"
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_sign_error = "⤫"
let g:ale_sign_warning = "⚠"
let g:ale_sign_info = "•"
let g:ale_sign_hint = "λ"
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = 'ALE: [%linter%] %s [%severity%]'
let b:ale_linters = {
      \  'python': ['pylint'],
      \  'sh': ['language_server'],
      \  'go': ['golint', 'gofmt', 'gopls']
      \}
let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \   'javascript': ['eslint'],
      \   'python': ['autopep8'],
      \   'go': ['gofmt', 'goimports']
      \}

fun! s:smoothScroll(up)
    execute "normal " . (a:up ? "\<c-y>" : "\<c-e>")
    redraw
    for l:count in range(3, &scroll, 2)
      sleep 7m
      execute "normal " . (a:up ? "\<c-y>" : "\<c-e>")
      redraw
    endfor
    " bring the cursor in the middle of screen 
    execute "normal M"
endf

"colorschemes------------------------------------------------------
set t_Co=256
set background=dark
syntax on
set termguicolors "for truecolor support, assuming you have it.
" may need the below especially with tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
colorscheme gruvbox
let g:gruvbox_contrast_dark="soft"
let g:gruvbox_contrast_light="hard"
let g:gruvbox_improved_strings=0
let g:gruvbox_improved_warnings=1
let g:gruvbox_termcolors=256
let g:gruvbox_italic=1
" Airline and tmuxline ---------------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#ale#enabled = 1
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

