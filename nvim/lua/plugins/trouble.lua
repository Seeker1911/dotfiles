return {
	"folke/trouble.nvim",
	opts = { focus = true, autoclose = true, max_items = 20 },
	cmd = "Trouble",
	keys = {
		{
			"<leader>ltD",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Trouble: All diagnostics",
		},
		{
			"<leader>ltd",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Trouble: Buffer diagnostics",
		},
		{
			"<leader>lts",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Trouble: Symbols",
		},
		{
			"<leader>ltr",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "Trouble: References",
		},
		{
			"<leader>ltl",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Trouble: Loclist",
		},
		{
			"<leader>ltq",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Trouble: Quickfix",
		},
	},
}
