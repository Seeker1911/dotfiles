--- @type NvPluginSpec
return {
	"hrsh7th/nvim-cmp",
	init = function()
		vim.opt.pumheight = 8
	end,
	opts = {
		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "luasnip" },
		},
	},
}
