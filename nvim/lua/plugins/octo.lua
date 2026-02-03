return {
	"pwntester/octo.nvim",
	cmd = "Octo",
	keys = {
		{ "<leader>gop", "<cmd>Octo pr list<cr>", desc = "Octo: List PRs" },
		{ "<leader>goP", "<cmd>Octo pr create<cr>", desc = "Octo: Create PR" },
		{ "<leader>goc", "<cmd>Octo pr checkout<cr>", desc = "Octo: Checkout PR" },
		{ "<leader>goi", "<cmd>Octo issue list<cr>", desc = "Octo: List issues" },
		{ "<leader>goI", "<cmd>Octo issue create<cr>", desc = "Octo: Create issue" },
		{ "<leader>gor", "<cmd>Octo review start<cr>", desc = "Octo: Start review" },
		{ "<leader>gos", "<cmd>Octo review submit<cr>", desc = "Octo: Submit review" },
		{ "<leader>goC", "<cmd>Octo review comments<cr>", desc = "Octo: View review comments" },
		{ "<leader>goa", "<cmd>Octo review submit approve<cr>", desc = "Octo: Approve PR" },
		{ "<leader>goR", "<cmd>Octo review submit request_changes<cr>", desc = "Octo: Request changes" },
		{ "<leader>gom", "<cmd>Octo pr merge squash<cr>", desc = "Octo: Merge PR (squash)" },
		{ "<leader>goM", "<cmd>Octo pr merge rebase<cr>", desc = "Octo: Merge PR (rebase)" },
		{ "<leader>gob", "<cmd>Octo pr browser<cr>", desc = "Octo: Open in browser" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		default_to_projects_v2 = true,
		suppress_missing_scope = {
			projects_v2 = true,
		},
	},
}
