let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if empty(glob('~/.config/nvim/site/autoload/plug.vim'))
      silent !curl -fLo ~/.config/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
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
      Plug 'neovim/nvim-lspconfig'
      Plug 'hrsh7th/cmp-nvim-lsp'
      Plug 'hrsh7th/cmp-buffer'
      Plug 'hrsh7th/nvim-cmp'
call plug#end()

let mapleader = ","
let maplocalleader = "\\"
let g:go_version_warning = 0

syntax on
set hidden " required for operations modifying multiple buffers like rename from LSP
set mouse=a
set expandtab
" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
" set completeopt-=preview
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
set updatetime=250 "smaller updatetime for cursorhold, also makes gitgutter more responsive
set wrap!
" if Linux colors dont work add filter logic on termguicolors
set termguicolors "for truecolor support, assuming you have it.
" set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim
set splitright
set shiftwidth=4
set shiftround
set noswapfile
set undofile
set t_Co=256
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


" may need the below especially with tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'ctags -R'
let g:rainbow_active=1
let g:gruvbox_contrast_dark="soft"
let g:gruvbox_contrast_light="medium"
let g:gruvbox_improved_strings=0
let g:gruvbox_improved_warnings=1
let g:gruvbox_termcolors=256
let g:gruvbox_italicize_strings=1
let g:gruvbox_italic=1
" Airline and tmuxline ---------------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#ale#enabled = 0
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
    let g:python3_host_prog = expand('~/.pyenv/versions/3.9.1/bin/python')
else "Mac
    let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
    let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')
endif

let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'vim', 'javascript']

map <leader>t :NERDTreeToggle<CR>
nnoremap <leader>uc :FloatermToggle<CR>
nnoremap <localleader>t :FloatermToggle<CR>
nnoremap <localleader>h :FloatermHide<CR>
nnoremap <localleader>b :Floaterms<CR>
nnoremap <localleader>n :FloatermNew<CR>
vnoremap <localleader>r :FloatermRepl<CR>


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

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  " Send literal ESC
  tnoremap <M-[> <Esc>
  tnoremap <C-v><Esc> <Esc>
" To use `ALT+{h,j,k,l}` to navigate windows from any mode: >
  tnoremap <A-h> <C-\><C-N><C-w>h
  tnoremap <A-j> <C-\><C-N><C-w>j
  tnoremap <A-k> <C-\><C-N><C-w>k
  tnoremap <A-l> <C-\><C-N><C-w>l
  inoremap <A-h> <C-\><C-N><C-w>h
  inoremap <A-j> <C-\><C-N><C-w>j
  inoremap <A-k> <C-\><C-N><C-w>k
  inoremap <A-l> <C-\><C-N><C-w>l
  nnoremap <A-h> <C-w>h
  nnoremap <A-j> <C-w>j
  nnoremap <A-k> <C-w>k
  nnoremap <A-l> <C-w>l
endif


highlight PmenuSel ctermbg=5
highlight ColorColumn ctermbg=232
highlight SignColumn ctermbg=256
highlight CursorColumn ctermbg=3

set background=dark
colorscheme gruvbox

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

function! s:b_lsp() abort
    nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> gR <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> gs <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <silent> gw <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
    nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> gt <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> gc <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
    nnoremap <silent> <C-s> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
    nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
endfunction

if executable('pylsp')
    augroup lsp
        autocmd!
        autocmd FileType go,vim,python call s:b_lsp()
        autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})
    augroup END

    lua require("lsp")
else
    echo('pylsp not found, skipping LSP setup')
endif

if filereadable(expand("~/.vim_background"))
  source ~/.vim_background
endif
