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
			"<cmd>Trouble symbols toggle focus=false win.position=right win.size=0.3<cr>",
			desc = "Trouble: Symbols",
		},
		{
			"<leader>ltr",
			"<cmd>Trouble lsp_references toggle focus=false win.position=right win.size=0.3<cr>",
			desc = "Trouble: References",
		},
		{
			"<leader>ltf",
			"<cmd>Trouble lsp_definitions toggle focus=false win.position=right win.size=0.3<cr>",
			desc = "Trouble: Definitions",
		},
		{
			"<leader>lti",
			"<cmd>Trouble lsp_implementations toggle focus=false win.position=right win.size=0.3<cr>",
			desc = "Trouble: Implementations",
		},
		{
			"<leader>ltt",
			"<cmd>Trouble lsp_type_definitions toggle focus=false win.position=right win.size=0.3<cr>",
			desc = "Trouble: Type definitions",
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
