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
    -- Lazy loading:
    -- Load on specific commands
    use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
    use {'tpope/vim-rhubarb' }
    -- Post-install/update hook with neovim command
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use { 'junegunn/fzf', run = 'fzf#install()' }
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
    use { 'jose-elias-alvarez/nvim-lsp-ts-utils' }
    use { 'sumneko/lua-language-server' }
    use { "L3MON4D3/LuaSnip",
        -- wants = 'friendly-snippets',
        run = "make install_jsregexp",
        after = 'nvim-cmp',
    }
    use { 'saadparwaiz1/cmp_luasnip', after = 'LuaSnip' }
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lua' , after = 'cmp_luasnip' }
    use { 'hrsh7th/cmp-nvim-lsp'} --, after = 'cmp-nvim-lua' }
    use { 'hrsh7th/cmp-buffer', after = 'cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
    use {
    'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use { 'p00f/nvim-ts-rainbow' }
    use { 'numToStr/Comment.nvim' }
    use { 'daschw/leaf.nvim' }
    use { 'jsit/toast.vim' }
    use { 'edeneast/nightfox.nvim' }
    use { "alexghergh/nvim-tmux-navigation" }
    use { 'tpope/vim-fugitive' }
    use { 'hashicorp/terraform-ls' }
    use { "williamboman/mason.nvim" }
    use { "williamboman/mason-lspconfig.nvim"} --, after = 'mason.nvim' }
    use { 'neovim/nvim-lspconfig'} --, after = 'mason.nvim' }
    use { 'jose-elias-alvarez/null-ls.nvim' } --, after = 'nvim-lspconfig' }
    use { "shatur/neovim-ayu" }
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {
            use_diagnostic_signs = true,
        }
      end
    }
    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
      tag = 'nightly', -- optional, updated every week. (see issue #1193)
      cmd = {'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeFindFile'},
      config = function()
        require("nvim-tree").setup {
        }
      end
    }
    --  use {
    --     "nvim-zh/colorful-winsep.nvim",
    --     config = function ()
    --         require('colorful-winsep').setup()
    --     end
    -- }   

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
