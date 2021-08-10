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
" let g:ale_disable_lsp = 1
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
      Plug 'hrsh7th/nvim-compe'
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
" set foldenable                 " enable folding
" set foldlevel=2
" set foldnestmax=4
" set foldmethod=indent
set updatetime=250 "smaller updatetime for cursorhold, also makes gitgutter more responsive
set wrap!
set termguicolors "for truecolor support, assuming you have it.
" set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim
set splitright
set shiftwidth=4
set shiftround
set noswapfile
" set undodir=~/.vim/undodir
set undofile
set t_Co=256



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
let g:airline#extensions#tabline#enabled = 1
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
    let g:python3_host_prog = expand('~/.pyenv/versions/3.7.6/bin/python')
else "Mac
    let g:python_host_prog = expand('~/.pyenv/versions/2.7.16/envs/neovim2/bin/python')
    let g:python3_host_prog = expand('~/.pyenv/versions/3.9.6/envs/neovim3/bin/python')
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

" ale ===================================================
"let g:ale_floating_preview = 1
"let g:ale_floating_window_border = []
"let g:ale_completion_autoimport = 1
"let g:ale_sign_column_always = 1
"let g:ale_python_pylint_use_global = 1
"" let g:ale_python_flake8_global = 1
"let g:ale_set_highlights = 1
"let g:ale_set_signs = 1
"let g:ale_sign_error = "⤫"
"let g:ale_sign_warning = "⚠"
"let g:ale_sign_info = "•"
"let g:ale_sign_hint = "λ"
"let g:ale_echo_msg_error_str = 'E'
"let g:ale_echo_msg_warning_str = 'W'
"let g:ale_echo_msg_format = 'ALE: [%linter%] %s [%severity%]'
"let b:ale_linters = {
"      \  'python': ['pylint', 'pyls', 'flake8'],
"      \  'sh': ['language_server'],
"      \  'go': ['golint', 'gofmt', 'gopls'],
"      \  'javascript': ['eslint']
"      \}
"let g:ale_fixers = {
"      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
"      \   'javascript': ['eslint'],
"      \   'python': ['autopep8', 'autoimport', 'yapf'],
"      \   'go': ['gofmt', 'goimports']
"      \}


function! s:lsp() abort
lua << EOF
    require'lspconfig'.gopls.setup{}
    require'lspconfig'.pyright.setup{}
    require'lspconfig'.pylsp.setup({enable=true,
                        plugins = {
                            flake8 = {enabled = true},
                            pyls_mypy = {
                                enabled = true,
                                live_mode = true}
                            },
                        })
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics,
            {
                virtual_text = false,
            }
        )
EOF

    let g:compe = {}
    let g:compe.enabled = v:true
    let g:compe.autocomplete = v:true
    let g:compe.debug = v:false
    let g:compe.min_length = 1
    let g:compe.preselect = 'enable'
    let g:compe.throttle_time = 80
    let g:compe.source_timeout = 200
    let g:compe.resolve_timeout = 800
    let g:compe.incomplete_delay = 400
    let g:compe.max_abbr_width = 100
    let g:compe.max_kind_width = 100
    let g:compe.max_menu_width = 100
    let g:compe.documentation = v:true

    let g:compe.source = {}
    let g:compe.source.path = v:true
    let g:compe.source.buffer = v:true
    let g:compe.source.calc = v:true
    let g:compe.source.nvim_lsp = v:true
    let g:compe.source.nvim_lua = v:true
    let g:compe.source.vsnip = v:true
    let g:compe.source.ultisnips = v:true
    let g:compe.source.luasnip = v:true
    let g:compe.source.emoji = v:true
    let g:diagnostic_enable_virtual_text = 0
    let g:diagnostic_enable_underline = 0
    let g:diagnostic_auto_popup_while_jump = 1
    let g:diagnostic_insert_delay = 1

    function! s:b_lsp() abort
        nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
        nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
        nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
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
    augroup lsp
        autocmd!
        autocmd FileType go,vim,python call s:b_lsp()
        autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})
    augroup END


    if executable('pyls')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': {server_info->['pyls']},
            \ 'whitelist': ['python'],
            \ })
    endif
endfunction
call s:lsp()

if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif
