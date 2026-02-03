return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
	keys = {
		{ "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Diffview: Open" },
		{ "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Diffview: Close" },
		{ "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: File history (repo)" },
		{ "<leader>gdf", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: File history (current)" },
		{ "<leader>gdp", "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<cr>", desc = "Diffview: PR diff (vs base)" },
		{ "<leader>gdm", "<cmd>DiffviewOpen HEAD~1<cr>", desc = "Diffview: Diff last commit" },
	},
	opts = {
		enhanced_diff_hl = true,
		view = {
			default = {
				layout = "diff2_horizontal",
			},
			merge_tool = {
				layout = "diff3_mixed",
			},
		},
		file_panel = {
			win_config = {
				position = "left",
				width = 35,
			},
		},
		keymaps = {
			view = {
				{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
			},
			file_panel = {
				{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
			},
			file_history_panel = {
				{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
			},
		},
	},
}
