return {
	"NeogitOrg/neogit",
	cmd = "Neogit",
	keys = {
		{ "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit: Open (quick)" },
		{ "<leader>gno", "<cmd>Neogit<cr>", desc = "Neogit: Open" },
		{ "<leader>gnc", "<cmd>Neogit commit<cr>", desc = "Neogit: Commit" },
		{ "<leader>gnp", "<cmd>Neogit push<cr>", desc = "Neogit: Push" },
		{ "<leader>gnP", "<cmd>Neogit pull<cr>", desc = "Neogit: Pull" },
		{ "<leader>gnl", "<cmd>Neogit log<cr>", desc = "Neogit: Log" },
		{ "<leader>gnb", "<cmd>Neogit branch<cr>", desc = "Neogit: Branch" },
		{ "<leader>gns", "<cmd>Neogit stash<cr>", desc = "Neogit: Stash" },
		{ "<leader>gnd", "<cmd>Neogit diff<cr>", desc = "Neogit: Diff" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		integrations = {
			diffview = true,
			telescope = true,
		},
		signs = {
			hunk = { "", "" },
			item = { "", "" },
			section = { "", "" },
		},
	},
}
