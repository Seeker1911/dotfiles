return {
	"0xKitsune/pr.nvim",
	cmd = "PR",
	keys = {
		{ "<leader>grr", "<cmd>PR<cr>", desc = "PR: List / open PRs" },
		{ "<leader>grs", "<cmd>PR submit<cr>", desc = "PR: Submit review" },
		{ "<leader>grc", "<cmd>PR close<cr>", desc = "PR: Exit review" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	opts = {},
}
