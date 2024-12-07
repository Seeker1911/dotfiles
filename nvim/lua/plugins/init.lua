return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre", -- uncomment for format on save
		opts = require("configs.conform"),
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = { enable = true },
			indent = { enable = true },
			fold = { enable = true },
			ensure_installed = {
				"python",
				"vim",
				"lua",
				"vimdoc",
				"python",
				"html",
				"css",
				"svelte",
				"javascript",
				"typescript",
				"bash",
				"regex",
			},
		},
	},
	{ "leafOfTree/vim-svelte-plugin", config = true, opts = {} },

	-- This would be neat but looks like you cant use custom themes with Base46
	-- {
	-- 	"scottmckendry/cyberdream.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- },
}

-- when a plugin is loaded, the files under lua/ are not immediately required by default; they are just available to be required. only if you have opts = {} or config = true, does lazy.nvim try to do require("my_plugin").setup(opts) after loading the plugin.
--
-- Lazy-loaded plugins are automatically loaded when their Lua modules are required, or when one of the lazy-loading handlers triggers
