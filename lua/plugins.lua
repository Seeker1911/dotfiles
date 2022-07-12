-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local fn = vim.fn
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  print('Cloning  Packer...')
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use { "ellisonleao/gruvbox.nvim" }
  use { 'wbthomason/packer.nvim' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'neovim/nvim-lspconfig' }
  -- Lazy loading:
  -- Load on specific commands
  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
 -- Post-install/update hook with neovim command
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'junegunn/fzf', run = ':fzf#install()' }
  use { 'junegunn/fzf.vim' }
  use { 'nvim-telescope/telescope.nvim',
        requires = { 
                {'nvim-lua/plenary.nvim'},
                { "nvim-telescope/telescope-file-browser.nvim" },
                { "nvim-telescope/telescope-github.nvim" },
        }
       }
  use { 'simrat39/symbols-outline.nvim' }
  use {
      'sudormrfbin/cheatsheet.nvim',
      requires = {
        {'nvim-telescope/telescope.nvim'},
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
      }
      }
  use { 'nvim-lua/plenary.nvim' }
  use { 'jose-elias-alvarez/null-ls.nvim' }
  use { 'jose-elias-alvarez/nvim-lsp-ts-utils' }
  use { 'sumneko/lua-language-server' }
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
  use {'ray-x/navigator.lua', requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}}
  use { 'alexghergh/nvim-tmux-navigation' }
  use {
  'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
  use { 'p00f/nvim-ts-rainbow' }
  use { 'numToStr/Comment.nvim' }
  use { 'daschw/leaf.nvim' }
  use { 'jsit/toast.vim' }
  use { 'edeneast/nightfox.nvim' }
  cmd([[
     augroup packer_user_config
     autocmd!
     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
     augroup end
  ]])

  if packer_bootstrap then  
    print('Running packer sync...')
    require('packer').sync()
  end
end)
