return {
	preset = "modern",
	notify = true,
	delay = 500,
	spec = {
		{ "<leader>f", group = "Find", icon = "󰍉" },
		{ "<leader>fl", group = "LSP", icon = "" },
		{ "<leader>fv", group = "Vim", icon = "" },
		{ "<leader>fh", group = "History", icon = "" },
		{ "<leader>c", group = "Code", icon = "" },
		{ "<leader>r", group = "Ruff/Refactor", icon = "" },
		{ "<leader>b", group = "Buffer", icon = "" },

		{ "<leader>l", group = "LSP", icon = "" },
		{ "<leader>lt", group = "Trouble", icon = "" },
		{ "<leader>lw", group = "Workspace", icon = "󰙀" },
		{ "<leader>ld", group = "Diagnostic", icon = "" },

		{ "<leader>g", group = "Git", icon = "" },
		{ "<leader>gh", group = "Hunk", icon = "" },
		{ "<leader>gd", group = "Diff", icon = "" },
		{ "<leader>gn", group = "Neogit", icon = "" },
		{ "<leader>go", group = "GitHub", icon = "" },
		{ "<leader>gt", group = "Toggle", icon = "󰔡" },

		{ "]", group = "Next", icon = "" },
		{ "[", group = "Previous", icon = "" },

		{ "g", group = "Go to", icon = "" },

		{ "z", group = "Fold", icon = "" },

		{ "<C-w>", group = "Window", icon = "" },
	},

	icons = {
		breadcrumb = "»",
		separator = "➜",
		group = "+",
	},
}
