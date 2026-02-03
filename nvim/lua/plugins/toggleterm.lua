return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = { "ToggleTerm", "TermExec" },
	keys = {
		{ "<leader>xx", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal: Float" },
		{ "<leader>xh", "<cmd>ToggleTerm direction=horizontal size=15<cr>", desc = "Terminal: Horizontal" },
		{ "<leader>xv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Terminal: Vertical" },
		{ "<leader>xa", "<cmd>ToggleTermToggleAll<cr>", desc = "Terminal: Toggle all" },
		{ "<leader>x1", "<cmd>1ToggleTerm<cr>", desc = "Terminal: #1" },
		{ "<leader>x2", "<cmd>2ToggleTerm<cr>", desc = "Terminal: #2" },
		{ "<leader>x3", "<cmd>3ToggleTerm<cr>", desc = "Terminal: #3" },
		{ "<leader>xs", "<cmd>TermSelect<cr>", desc = "Terminal: Select" },
		-- Terminal mode mappings (work inside terminal)
		{ "<C-\\>", "<cmd>ToggleTerm<cr>", mode = "t", desc = "Terminal: Toggle" },
		{ "<C-x>", "<C-\\><C-n>", mode = "t", desc = "Terminal: Exit to normal" },
	},
	opts = {
		shade_terminals = true,
		shading_factor = 2,
		float_opts = {
			border = "rounded",
			winblend = 3,
		},
	},
}
