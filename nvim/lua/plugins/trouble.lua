return {
	"folke/trouble.nvim",
	opts = { focus = true, autoclose = true, max_items = 20 },
	cmd = "Trouble",
	keys = {
		{
			"<leader>tD",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Trouble: Show all diagnostics",
		},
		{
			"<leader>td",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Trouble: Show buffer diagnostics",
		},
		{
			"<leader>ts",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Trouble: Show symbols",
		},
		{
			"<leader>tl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "Trouble: Show LSP definitions/references",
		},
		{
			"<leader>tL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Trouble: Show location list",
		},
		{
			"<leader>xQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Trouble: Show quickfix list",
		},
	},
}
