if empty(glob('~/.config/nvim/plug.vim'))
      silent !curl -fLo ~/.config/nvim/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
let g:ale_disable_lsp = 1
call plug#begin('~/.config/nvim/plugged')
      Plug 'christoomey/vim-tmux-navigator'
      Plug 'morhetz/gruvbox'
      Plug 'nightsense/snow', {'on': 'LightSide'}
      Plug 'NLKNguyen/papercolor-theme'
      Plug 'rakr/vim-two-firewatch'
      Plug 'kkga/vim-envy'
      Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'}
      Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
      Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
      Plug 'junegunn/fzf.vim'
      Plug 'luochen1990/rainbow'
      Plug 'vim-airline/vim-airline'
      Plug 'vim-airline/vim-airline-themes'
      Plug 'tpope/vim-fugitive'
      Plug 'tpope/vim-obsession'
      Plug 'tpope/vim-commentary'
      Plug 'tpope/vim-rhubarb'
      Plug 'tpope/vim-dadbod'
      Plug 'tpope/vim-dispatch'
      Plug 'majutsushi/tagbar'
      Plug 'tmux-plugins/vim-tmux-focus-events'
      Plug 'simnalamburt/vim-mundo'
      Plug 'voldikss/vim-floaterm'
      Plug 'voldikss/fzf-floaterm'
      Plug 'windwp/vim-floaterm-repl'
      Plug 'dense-analysis/ale'
      Plug 'ncm2/ncm2'
      Plug 'ncm2/ncm2-jedi'
      Plug 'roxma/nvim-yarp'
      Plug 'autozimu/LanguageClient-neovim', {
	      \ 'branch': 'next',
	      \ 'do': 'bash install.sh',
	      \ }
      Plug 'ryanoasis/vim-devicons' " always last
call plug#end()
set background=dark
colorscheme gruvbox

let mapleader = ","
let maplocalleader = "\\"
let g:go_version_warning = 0

syntax on
set hidden " required for operations modifying multiple buffers like rename from LSP
set mouse=a
set expandtab
" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
set encoding=utf8
set nocompatible	       " required, not vi compatible
set modelines=0		       " fix security exploits
set wildmenu		       " autocomplete command menu
set number		       " show line numbers
set ignorecase		      " ignore caps when searching
set smartcase		      " unless a capital is used
set infercase		      " smart auto-completion casing
set wildignorecase	      " ignore case on files and directories
set tags=./tags;/               " ctags read subdirectories
set clipboard=unnamed          " use system clipboard (OS X)
set foldenable                 " enable folding
set foldlevel=6
set foldnestmax=6
set foldmethod=indent
set updatetime=250 "smaller updatetime for cursorhold, also makes gitgutter more responsive
set wrap!
" set termguicolors "for truecolor support, assuming you have it.
" set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim
set splitright
set shiftwidth=4
set shiftround
set noswapfile
set undodir=~/.vim/undodir
set undofile
set t_Co=256
set background=dark
colorscheme gruvbox



" may need the below especially with tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:rainbow_active=1
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
let g:airline_theme='snow_dark'
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

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let uname = substitute(system('uname'), '\n', '', '')
let home = system('whoami')
if uname == 'Linux'
    let g:python_host_prog = expand('~/.pyenv/versions/2.7.15/envs/neovim2/bin/python')
    let g:python3_host_prog = expand('~/.pyenv/versions/3.9.1/envs/neovim3/bin/python')
else "Mac
    let g:python_host_prog = expand('~/.pyenv/versions/2.7.16/envs/neovim2/bin/python')
    let g:python3_host_prog = expand('~/.pyenv/versions/3.8.2/envs/neovim3/bin/python')
endif

map <leader>t :NERDTreeToggle<CR>
nnoremap <leader>uc :FloatermToggle<CR>
nnoremap <localleader>t :FloatermToggle<CR>
vnoremap <leader>uc :FloatermRepl<CR>

map <leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
" ripgrep fzf find word under cursor in nearby files.
map <leader>F :Rg<CR>
map <leader>f :Files<CR>
map <leader>b :Buffers<CR>
nmap <leader>c :Commands<CR>
nmap <leader>T :TagbarToggle<CR>
nmap <leader>r :RainbowToggle<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap jj <ESC>
inoremap JJ <ESC>

nnoremap <silent> <leader>H :set hlsearch<CR>
nnoremap <silent> <leader>h :set nohlsearch<CR>

" tnoremap <Esc> <C-\><C-n>
" tnoremap jj <C-\><C-n>


highlight PmenuSel ctermbg=5
highlight ColorColumn ctermbg=232
highlight SignColumn ctermbg=256
highlight CursorColumn ctermbg=3


function! OpenURLUnderCursor()
  let s:uri = expand('<cWORD>')
  let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = shellescape(s:uri, 1)
  if s:uri != ''
    silent exec "!open '".s:uri."'"
    :redraw!
  endif
endfunction
nnoremap gx :call OpenURLUnderCursor()<CR>

" ale ===================================================
let g:ale_floating_preview = 1
let g:ale_floating_window_border = []
let g:ale_completion_autoimport = 1
let g:ale_sign_column_always = 1
let g:ale_python_pylint_use_global = 1
let g:ale_python_flake8_global = 1
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
      \  'python': ['pylint', 'pyright', 'flake8', 'pyls', 'mypy'],
      \  'sh': ['language_server'],
      \  'go': ['golint', 'gofmt', 'gopls']
      \}
let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \   'javascript': ['eslint'],
      \   'python': ['autopep8', 'pyright', 'mypy', 'pyls'],
      \   'go': ['gofmt', 'goimports']
      \}


if has('nvim')
	" enable ncm2 for all buffers
	autocmd BufEnter * call ncm2#enable_for_buffer()
endif

" Language server ===================================================
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['~/.pyenv/shims/pyls'],
    \ 'go': ['~/go/bin/gopls'],
    \ }

" language client ===================================================

let g:LanguageClient_fzfContextMenu = 1
function! SetLSPShortcuts()
  nnoremap <F5> :call LanguageClient_contextMenu()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
  nnoremap <silent>K :call LanguageClient#textDocument_hover()<CR>
  nnoremap <silent>gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>la :call LanguageClient#textDocument_codeAction()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c,python,js,go call SetLSPShortcuts()
augroup END


let g:LanguageClient_hoverPreview = 'always'
let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_loggingFile = expand('~/.vim/LanguageClient.log')
let g:LanguageClient_loggingLevel = 'DEBUG'
" dont show inline errors" Valid Options:" "All" | "No" | "CodeLens" | "Diagnostics"
let g:LanguageClient_useVirtualText = "CodeLens"
let g:LanguageClient_settingsPath = "~/.config/lc_settings.json"
" needed for neovim LSP but not languageClient-neovim
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif
