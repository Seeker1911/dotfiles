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
    use { "sainnhe/everforest" }
    use { "shatur/neovim-ayu" }
    use { 'edeneast/nightfox.nvim' }
    use { 'jsit/toast.vim' }
    use { 'daschw/leaf.nvim' }
    use { 'lewis6991/gitsigns.nvim' }
    use { 'savq/melange-nvim' }
    use { "scottmckendry/cyberdream.nvim" }

    use {
          'goolord/alpha-nvim',
          -- config = function() require("alpha") end
    }
    use { 'HiPhish/nvim-ts-rainbow2' }
    use { "sainnhe/gruvbox-material" }
    use {
    'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
use ({
    'nvimdev/lspsaga.nvim',
    after = 'nvim-lspconfig',
    config = function()
        require('lspsaga').setup({
            ui = {beacon = {enable= true}, code_action = ''},
            finder = {methods = {tyd='textDocument/typeDefinition'}},
            })
    end,
})
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
    -- Unless you are still migrating, remove the deprecated commands from v1.x
    cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

    use {
      "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
        }
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
                { window = {options={signcolumn="yes"}}}
        }
      end
    }
    use {
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup {
                window = {width = 180,
                    options = {
                      signcolumn = "yes", -- disable signcolumn
                      -- number = false, -- disable number column
                      -- relativenumber = false, -- disable relative numbers
                      -- cursorline = false, -- disable cursorline
                      -- cursorcolumn = false, -- disable cursor column
                      -- foldcolumn = "0", -- disable fold column
                      -- list = false, -- disable whitespace characters
                    },
                }
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }
    -- Lazy loading:
    use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
    use {'tpope/vim-rhubarb'}
    use {'tpope/vim-abolish'}
    --
    -- fuzzy find
    use { 'junegunn/fzf.vim' }
    use { 'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
    use { 'nvim-telescope/telescope.nvim',
        requires = {
                {'nvim-lua/plenary.nvim'},
                { "nvim-telescope/telescope-file-browser.nvim" },
                { "nvim-telescope/telescope-github.nvim" },
        }
    }
    -- LSP
    use { 'davidhalter/jedi-vim' }
    use { 'sumneko/lua-language-server' }
    use { "L3MON4D3/LuaSnip",
        -- wants = 'friendly-snippets',
        run = "make install_jsregexp",
        after = 'nvim-cmp',
    }
    use { 'folke/neodev.nvim',
        config = function()
            require('neodev').setup{}
        end
    }
    use { 'neovim/nvim-lspconfig'} --, after = 'mason.nvim' }
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    }
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
    use { 'evanleck/vim-svelte',
        branch = "main",
        requires = {
            'pangloss/vim-javascript',
            'othree/html5.vim'
        },
     ft = 'svelte',
      config = function()
        vim.g.svelte_preprocessors = { 'ts' }
        -- require("vim-svelte").setup {
        -- }
      end
    }
    use {
      "pmizio/typescript-tools.nvim",
      requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    }

    -- completion
    use { 'saadparwaiz1/cmp_luasnip' } --, after = 'LuaSnip' }
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lua' } -- , after = 'cmp_luasnip' }
    use { 'hrsh7th/cmp-nvim-lsp'} --, after = 'cmp-nvim-lua' }
    use { 'hrsh7th/cmp-buffer', after = 'cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
    use({"petertriho/cmp-git", requires = "nvim-lua/plenary.nvim"})
    use { 'andersevenrud/cmp-tmux' }
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    -- utils
    use { 'rcarriga/nvim-notify'}
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
    use {
      'pwntester/octo.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        'kyazdani42/nvim-web-devicons',
      },
      config = function ()
        require"octo".setup({
            use_local_fs = true,
            enable_builtin = true,
            suppress_missing_scope = {
                projects_v2 = true,
            }
        })
      end
    }
    use {
      "folke/which-key.nvim",
      config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("which-key").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }
    --DAP (debugger)
    use { 'mfussenegger/nvim-dap' }
    use { "mxsdev/nvim-dap-vscode-js" }
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
    -- use {
    --   "microsoft/vscode-js-debug",
    --   opt = true,
    --     -- this will likely fail, I manually installed in .config/nvim/plugged
    --   -- run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out" 
    -- }


--- END
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
