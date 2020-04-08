if empty(glob('~/.config/nvim/plug.vim'))
      silent !curl -fLo ~/.config/nvim/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.config/nvim/plugged')
      Plug 'dense-analysis/ale'
      Plug 'davidhalter/jedi-vim'
      Plug 'ncm2/float-preview.nvim'
      Plug 'christoomey/vim-tmux-navigator'
      Plug 'nightsense/snow', {'on': 'LightSide'}
      Plug 'NLKNguyen/papercolor-theme'
      Plug 'fatih/vim-go' ", { 'do': ':GoUpdateBinaries'}
      Plug 'morhetz/gruvbox'
      Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
      Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
      Plug 'junegunn/fzf.vim'
      Plug 'craigemery/vim-autotag'
      Plug 'vim-airline/vim-airline'
      Plug 'vim-airline/vim-airline-themes'
      Plug 'ryanoasis/vim-devicons'
      Plug 'tpope/vim-fugitive'
      Plug 'tpope/vim-commentary'
      Plug 'tpope/vim-rhubarb'
      Plug 'tpope/vim-dadbod'
      Plug 'majutsushi/tagbar'
      "Plug 'guns/xterm-color-table.vim'
      "Plug 'tmux-plugins/vim-tmux-focus-events'
      "Plug 'godlygeek/csapprox'
      "Plug 'simnalamburt/vim-mundo'
      "Plug 'junegunn/goyo.vim'
      "Plug 'jremmen/vim-ripgrep'
      Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
      "Plug 'rhysd/git-messenger.vim'
      if has('nvim')
          Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
      else
          Plug 'Shougo/deoplete.nvim'
          Plug 'roxma/nvim-yarp'
          Plug 'roxma/vim-hug-neovim-rpc'
      endif
      Plug 'deoplete-plugins/deoplete-jedi'
call plug#end()

let mapleader = ","
let maplocalleader = "\\"

"source $HOME/dotfiles/vim/filehandling.vimrc
"source $HOME/dotfiles/vim/autocommands.vimrc
"source $HOME/dotfiles/vim/hi.vimrc
"source $HOME/dotfiles/vim/settings.vimrc
"source $HOME/dotfiles/vim/functions.vimrc
"source $HOME/dotfiles/vim/plugins.vimrc
"source $HOME/dotfiles/vim/coc.vimrc "coc gets its own
"source $HOME/dotfiles/vim/remaps.vimrc
"source $HOME/dotfiles/vim/colors.vimrc

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




let uname = substitute(system('uname'), '\n', '', '')
if uname == 'Linux'
	let g:python_host_prog = '/$PYENV_ROOT/versions/neovim2/bin/python'
	let g:python3_host_prog = '/$PYENV_ROOT/versions/neovim3/bin/python'
else "Mac
	let g:python_host_prog = '/Users/meadm1/.pyenv/versions/neovim2/bin/python'
	let g:python3_host_prog = '/Users/meadm1/.pyenv/versions/neovim/bin/python'
endif



map <leader>t :NERDTreeToggle<CR>
map <leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
" ripgrep fzf find word under cursor in nearby files.
map <leader>F :Rg<CR>
map <leader>f :Files<CR>
map <leader>b :Buffers<CR>
nmap <leader>T :TagbarToggle<CR>

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
highlight link CocErrorSign GruvboxRed

set t_Co=256

let iterm_profile = $ITERM_PROFILE
if iterm_profile == "gruvbox dark"
    set background=dark
    colorscheme gruvbox
elseif iterm_profile == "gruvbox light"
    set background=light
    colorscheme gruvbox
elseif iterm_profile == "snow light"
    set background=light
    colorscheme snow
elseif iterm_profile == "snow night"
    set background=dark
    colorscheme snow
else 				"default
    set background=dark
    colorscheme gruvbox
endif

"---------------------- COC settings --------------------------------
let $NVIM_COC_LOG_LEVEL = 'debug'
let g:coc_global_extensions = ['coc-python']
nmap <leader>rn <Plug>(coc-rename)
" Fix autofix problem of current line
"nmap <leader>qf  <Plug>(coc-fix-current)
" coc open browser current file
nnoremap <leader>bo :call CocAction('runCommand', 'git.browserOpen')<CR>
nnoremap <leader>ct <Plug>(coc-terminal-toggle)
" navigate chunks of current buffer
nmap <silent> [g <Plug>(coc-git-prevchunk)
nmap <silent> ]g <Plug>(coc-git-nextchunk)
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"coc action
 nnoremap <silent> <space>a :<C-u>CocAction<CR>
" Show all diagnostics
nnoremap <silent> <space>d :<C-u>CocList diagnostics<CR>
" Manage extensions
nnoremap <silent> <space>e :<C-u>CocList extensions<CR>
" Show commands
nnoremap <silent> <space>c :<C-u>CocList commands<CR>
" Search workspace symbols
noremap <silent> <space>s :<C-u>CocList -I symbols<CR>
" Do default action for next item.
nnoremap <silent> <space>j :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k :<C-u>CocPrev<CR>
" Remap for format selected region need to fix
"vmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
" Show config
nnoremap <silent> <space>g :<C-u>CocConfig<CR>
" Show info
nnoremap <silent> <space>i :<C-u>CocInfo<CR>
" Find symbol of current document
nnoremap <silent> <space>o :<C-u>CocList outline<CR>
" Resume latest coc list
nnoremap <silent> <space>p :<C-u>CocListResume<CR>
imap <C-l> <Plug>(coc-snippets-expand)

