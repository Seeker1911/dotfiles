return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{ "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
	},
	cmd = "CodeCompanionChat",
	opts = function()
		return require("configs.codecompanion")
	end,
	config = true,
}
