if empty(glob('~/.config/nvim/plug.vim'))
      silent !curl -fLo ~/.config/nvim/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.config/nvim/plugged')
      "Plug 'w0rp/ale'
      "Plug 'davidhalter/jedi-vim'
      Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
      Plug 'christoomey/vim-tmux-navigator'
      Plug 'nightsense/snow', {'on': 'LightSide'}
      Plug 'NLKNguyen/papercolor-theme'
      Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'}
      Plug 'tmux-plugins/vim-tmux-focus-events'
      Plug 'morhetz/gruvbox'
      Plug 'godlygeek/csapprox'
      Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
      Plug 'guns/xterm-color-table.vim'
      Plug 'simnalamburt/vim-mundo'
      Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
      Plug 'junegunn/fzf.vim'
      Plug 'craigemery/vim-autotag'
      Plug 'vim-airline/vim-airline'
      Plug 'vim-airline/vim-airline-themes'
      Plug 'jremmen/vim-ripgrep'
      Plug 'ryanoasis/vim-devicons'
      Plug 'tpope/vim-fugitive'
      Plug 'tpope/vim-commentary'
      Plug 'tpope/vim-rhubarb'
      Plug 'majutsushi/tagbar'
      "Plug 'neovim/nvim-lsp'
call plug#end()

let mapleader = ","
let maplocalleader = "\\"

"filetypes
filetype plugin indent on
source $HOME/dotfiles/vim/filehandling.vimrc
source $HOME/dotfiles/vim/autocommands.vimrc
source $HOME/dotfiles/vim/hi.vimrc
source $HOME/dotfiles/vim/settings.vimrc
source $HOME/dotfiles/vim/functions.vimrc
source $HOME/dotfiles/vim/plugins.vimrc
source $HOME/dotfiles/vim/coc.vimrc "coc gets its own
source $HOME/dotfiles/vim/remaps.vimrc
source $HOME/dotfiles/vim/colors.vimrc
