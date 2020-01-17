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
      Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'}
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
      "Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
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

source $HOME/dotfiles/vim/burn.vimrc
"source $HOME/dotfiles/vim/filehandling.vimrc
"source $HOME/dotfiles/vim/autocommands.vimrc
"source $HOME/dotfiles/vim/hi.vimrc
"source $HOME/dotfiles/vim/settings.vimrc
"source $HOME/dotfiles/vim/functions.vimrc
"source $HOME/dotfiles/vim/plugins.vimrc
"source $HOME/dotfiles/vim/coc.vimrc "coc gets its own
"source $HOME/dotfiles/vim/remaps.vimrc
"source $HOME/dotfiles/vim/colors.vimrc

