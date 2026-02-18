-- when a plugin is loaded, the files under lua/ are not immediately required by default; they are just available to be required. only if you have opts = {} or config = true, does lazy.nvim try to do require("my_plugin").setup(opts) after loading the plugin.
-- Lazy-loaded plugins are automatically loaded when their Lua modules are required, or when one of the lazy-loading handlers triggers
return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        cmd = "Telescope",
        opts = function()
            return require("configs.telescope")
        end,
    },
    {
        "smjonas/inc-rename.nvim",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "IncRename" },
        opts = {},
    },
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        opts = require("configs.conform"),
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        opts = function()
            return require("configs.treesitter")
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
            -- Register markdown parser for octo.nvim buffers
            vim.treesitter.language.register('markdown', 'octo')
        end,
    },

    { "leafOfTree/vim-svelte-plugin", config = true,              opts = {} },

    -- This would be neat but looks like you cant use custom themes with Base46
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
        opts = require("configs.cyberdream"),
    },

    { "ellisonleao/gruvbox.nvim",     priority = 1000,            config = true, opts = {} },

    { "rakr/vim-one",                 lazy = false,               priority = 1000 },

    { "nvim-lua/plenary.nvim" },

    { "nvzone/volt" },

    { "nvzone/minty",                 cmd = { "Huefy", "Shades" } },

    {
        "nvim-tree/nvim-web-devicons",
    },

    -- file managing , picker etc
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        opts = function()
            return require("configs.nvimtree")
        end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        cmd = "WhichKey",
        opts = function()
            return require("configs.whichkey")
        end,
    },

    -- git stuff
    { "tpope/vim-fugitive", cmd = { "Git" } },
    { "tpope/vim-rhubarb" },
    {
        "lewis6991/gitsigns.nvim",
        event = "User FilePost",
        opts = function()
            return require("configs.gitsigns")
        end,
    },

    -- lsp stuff
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
        opts = function()
            return require("configs.mason")
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = "User FilePost",
        config = function()
            require("configs.lspconfig").defaults()
        end,
    },

    {
        "saghen/blink.cmp",
        version = "1.*",
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
                opts = { history = true, updateevents = "TextChanged,TextChangedI" },
                config = function(_, opts)
                    require("luasnip").config.set_config(opts)
                    require("configs.luasnips")
                end,
            },
            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },
            },
        },
        opts = function()
            return require("configs.blink")
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "InsertEnter",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },
    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
    },
}
