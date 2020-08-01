if empty(glob('~/.config/nvim/plug.vim'))
      silent !curl -fLo ~/.config/nvim/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.config/nvim/plugged')
      Plug 'dense-analysis/ale'
      " Plug 'davidhalter/jedi-vim'
      " Plug 'ncm2/float-preview.nvim'
      Plug 'ncm2/ncm2'
      Plug 'ncm2/ncm2-jedi'
      Plug 'roxma/nvim-yarp'

      Plug 'christoomey/vim-tmux-navigator'
      Plug 'nightsense/snow', {'on': 'LightSide'}
      Plug 'NLKNguyen/papercolor-theme'
      Plug 'fatih/vim-go' ", { 'do': ':GoUpdateBinaries'}
      Plug 'morhetz/gruvbox'
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
      Plug 'majutsushi/tagbar'
      Plug 'tmux-plugins/vim-tmux-focus-events'
      Plug 'godlygeek/csapprox'
      Plug 'simnalamburt/vim-mundo'
      Plug 'mhinz/vim-startify'
      "Plug 'craigemery/vim-autotag'
      "Plug 'guns/xterm-color-table.vim'
      "Plug 'junegunn/goyo.vim' "distraction free writing
      "Plug 'jremmen/vim-ripgrep'
      " Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
      "Plug 'rhysd/git-messenger.vim'
      Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
      if has('nvim')
          " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
      else
          Plug 'Shougo/deoplete.nvim'
          Plug 'roxma/nvim-yarp'
          Plug 'roxma/vim-hug-neovim-rpc'
      endif
      Plug 'deoplete-plugins/deoplete-jedi'
      Plug 'ryanoasis/vim-devicons' " always last
call plug#end()

let mapleader = ","
let maplocalleader = "\\"
let g:go_version_warning = 0

set hidden
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
set foldlevel=10
set foldnestmax=2
set foldmethod=indent
set updatetime=250 "smaller updatetime for cursorhold, also makes gitgutter more responsive
syntax on

set termguicolors "for truecolor support, assuming you have it.
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




let uname = substitute(system('uname'), '\n', '', '')
let home = system('whoami')
if uname == 'Linux'
	let g:python_host_prog = expand('home/versions/neovim2/bin/python')
	let g:python3_host_prog = expand('home/versions/neovim3/bin/python')
else "Mac
	let g:python_host_prog = expand('~/.pyenv/versions/2.7.15/envs/neovim2/bin/python')
	let g:python3_host_prog = expand('~/.pyenv/versions/3.8.2/envs/neovim3/bin/python')
endif



map <leader>t :NERDTreeToggle<CR>
map <leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
" ripgrep fzf find word under cursor in nearby files.
map <leader>F :Rg<CR>
map <leader>f :Files<CR>
map <leader>b :Buffers<CR>
nmap <leader>T :TagbarToggle<CR>
nmap <leader>r :RainbowToggle<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<CR>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap jj <ESC>
inoremap JJ <ESC>

nnoremap <nowait> <silent> <leader>h :set hlsearch<cr>
nnoremap <nowait> <silent> <leader>nh :set nohlsearch<cr>

highlight PmenuSel ctermbg=5
highlight ColorColumn ctermbg=232
highlight SignColumn ctermbg=256

set t_Co=256

let iterm_profile = $ITERM_PROFILE
if iterm_profile == "gruvbox dark"
    set background=dark
    colorscheme gruvbox
    let g:airline_theme='snow_dark'
elseif iterm_profile == "gruvbox light"
    set background=light
    colorscheme gruvbox
    let g:airline_theme='gruvbox'
elseif iterm_profile == "snow light"
    set background=light
    colorscheme snow
    let g:airline_theme='snow_light'
elseif iterm_profile == "snow night"
    set background=dark
    colorscheme snow
    let g:airline_theme='snow_dark'
else 				"default
    set background=dark
    colorscheme gruvbox
endif


" ale ===================================================
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
      \  'python': ['pylint', 'flake8', 'pyls'],
      \  'sh': ['language_server'],
      \  'go': ['golint', 'gofmt', 'gopls']
      \}
let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \   'javascript': ['eslint'],
      \   'python': ['autopep8'],
      \   'go': ['gofmt', 'goimports']
      \}


" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" deoplete options ===================================================
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1


" Language server ===================================================
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['~/.pyenv/shims/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }

" language client ===================================================
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

function! SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>la :call LanguageClient#textDocument_codeAction()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c,python,js,go call SetLSPShortcuts()
augroup END

let g:LanguageClient_hoverPreview = 'always'
let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_loggingFile = expand('~/.vim/LanguageClient.log')
let g:LanguageClient_loggingLevel = 'DEBUG'
" dont show inline errors" Valid Options: "All" | "No" | "CodeLens" | "Diagnostics"
let g:LanguageClient_useVirtualText = "CodeLens"
