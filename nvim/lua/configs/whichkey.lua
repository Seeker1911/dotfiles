return {
	preset = "modern",
	notify = true,
	delay = 500,
	spec = {
		{ "<leader>f", group = "Find", icon = "󰍉" },
		{ "<leader>fl", group = "LSP", icon = "" },
		{ "<leader>fv", group = "Vim", icon = "" },
		{ "<leader>fh", group = "History", icon = "" },
		{ "<leader>a", group = "AI", icon = "" },
		{ "<leader>x", group = "Terminal", icon = "" },
		{ "<leader>c", group = "Code", icon = "" },
		{ "<leader>r", group = "Ruff/Refactor", icon = "" },
		{ "<leader>9", group = "99 Agent", icon = "" },
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

		{ "<leader>G", group = "Ghostty", icon = "󰊠" },
		{ "<leader>Gs", group = "Splits" },
		{ "<leader>Gsl", "<Nop>", desc = "⌘⇧L  New split right" },
		{ "<leader>Gsh", "<Nop>", desc = "⌘⇧H  New split left" },
		{ "<leader>Gn", group = "Navigate" },
		{ "<leader>Gnl", "<Nop>", desc = "⌘⌥L  Go to split right" },
		{ "<leader>Gnh", "<Nop>", desc = "⌘⌥H  Go to split left" },
		{ "<leader>Gr", group = "Resize" },
		{ "<leader>Grl", "<Nop>", desc = "⌘⌃→  Resize split right" },
		{ "<leader>Grh", "<Nop>", desc = "⌘⌃←  Resize split left" },
		{ "<leader>Gp", "<Nop>", desc = "⌘⇧P  Command palette" },
		{ "<leader>Gq", "<Nop>", desc = "⌘S   Quick terminal" },
		{ "<leader>Gv", "<Nop>", desc = "⌘⇧T  Toggle visibility" },
	},

	icons = {
		breadcrumb = "»",
		separator = "➜",
		group = "+",
	},
}
