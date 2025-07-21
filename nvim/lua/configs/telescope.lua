return {
	defaults = {
		prompt_prefix = "   ",
		selection_caret = " ",
		entry_prefix = " ",
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
			},
			width = 0.87,
			height = 0.80,
		},
		mappings = {
			n = { ["q"] = require("telescope.actions").close },
		},
		file_ignore_patterns = {
			"node_modules/",
			".idea/",
			".git/",
			"dist/",
			"build/",
			"target/",
			"vendor/",
			"%.lock",
			"package%-lock%.json",
			"yarn%.lock",
			"%.min%.js",
			"%.min%.css",
			"coverage/",
			"%.DS_Store",
			"%.env",
			"%.log",
		},
	},
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		{ "nvim-telescope/telescope-fzy-native.nvim" },
	},

	extensions_list = { "themes", "terms", "fzf" },
	extensions = {},
	-- example to add keys in the plugin itself
	keys = {
		"<leader>fp",
		function()
			require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
		end,
		desc = "Find Plugin File",
	},
}
