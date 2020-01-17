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
	let g:python_host_prog = '/home/linuxbrew/.linuxbrew/bin/python'
	let g:python3_host_prog = '/home/michael_mead/.pyenv/versions/neovim3/bin/python'
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
