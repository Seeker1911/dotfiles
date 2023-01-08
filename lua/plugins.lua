-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local fn = vim.fn
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  print('Cloning  Packer...')
  Packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' }

    -- colors & ui
    use { "ellisonleao/gruvbox.nvim" }
    use { "shatur/neovim-ayu" }
    use { 'edeneast/nightfox.nvim' }
    use { 'jsit/toast.vim' }
    use { 'daschw/leaf.nvim' }
    use({
    'rose-pine/neovim',
    as = 'rose-pine',
    -- config = function()
    --     vim.cmd('colorscheme rose-pine')
    -- end
    })
    use { 'p00f/nvim-ts-rainbow' }
    use {
    'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use { 'kyazdani42/nvim-web-devicons' }
    -- Post-install/update hook with neovim command
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use { 'simrat39/symbols-outline.nvim' }
    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
      tag = 'nightly', -- optional, updated every week. (see issue #1193)
      cmd = {'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeFindFile'},
      config = function()
        require("nvim-tree").setup {
                { window = {options={signcolumn="yes"}}}
        }
      end
    }
    use {
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }
    --
    -- Lazy loading:
    use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
    use {'tpope/vim-rhubarb' }
    --
    -- fuzzy find
    use { 'junegunn/fzf', run = 'fzf#install()' }
    use { 'junegunn/fzf.vim' }
    use { 'nvim-telescope/telescope.nvim',
        requires = {
                {'nvim-lua/plenary.nvim'},
                { "nvim-telescope/telescope-file-browser.nvim" },
                { "nvim-telescope/telescope-github.nvim" },
        }
    }

    -- LSP
    use { 'jose-elias-alvarez/nvim-lsp-ts-utils' }
    use { 'sumneko/lua-language-server' }
    use { "L3MON4D3/LuaSnip",
        -- wants = 'friendly-snippets',
        run = "make install_jsregexp",
        after = 'nvim-cmp',
    }
    use { "williamboman/mason.nvim" }
    use { "williamboman/mason-lspconfig.nvim"} --, after = 'mason.nvim' }
    use { 'neovim/nvim-lspconfig'} --, after = 'mason.nvim' }
    use { 'jose-elias-alvarez/null-ls.nvim' } --  , after = 'nvim-lspconfig' }
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {
            use_diagnostic_signs = true,
        }
      end
    }
    use { 'hashicorp/terraform-ls' }

    -- completion
    use { 'saadparwaiz1/cmp_luasnip' } --, after = 'LuaSnip' }
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lua' } -- , after = 'cmp_luasnip' }
    use { 'hrsh7th/cmp-nvim-lsp'} --, after = 'cmp-nvim-lua' }
    use { 'hrsh7th/cmp-buffer', after = 'cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-nvim-lsp-signature-help' }

    -- utils
    use { 'folke/neodev.nvim',
        config = function()
            require('neodev').setup{}
        end
    }
    use { 'numToStr/Comment.nvim' }
    use { "alexghergh/nvim-tmux-navigation" }
    use { 'tpope/vim-fugitive' }
    use {
      'sudormrfbin/cheatsheet.nvim',
      requires = {
        {'nvim-telescope/telescope.nvim'},
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
      }
    }
    use({
      "jackMort/ChatGPT.nvim",
        config = function()
          require("chatgpt").setup({
            -- optional configuration
          })
        end,
        requires = {
          "MunifTanjim/nui.nvim",
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope.nvim"
        }
    })

    cmd([[
     augroup packer_user_config
     autocmd!
     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
     augroup end
    ]])

    if Packer_bootstrap then
    print('Running packer sync...')
    require('packer').sync()
    end
end)
