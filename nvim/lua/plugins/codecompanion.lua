return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{ "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
	},
	cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
	keys = {
		{ "<leader>ac", "<cmd>CodeCompanionChat toggle<cr>", desc = "AI: Toggle chat" },
		{ "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "AI: Actions menu" },
		{ "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = "v", desc = "AI: Actions (selection)" },
		{ "<leader>ae", "<cmd>CodeCompanion /explain<cr>", mode = "v", desc = "AI: Explain code" },
		{ "<leader>af", "<cmd>CodeCompanion /fix<cr>", mode = "v", desc = "AI: Fix code" },
		{ "<leader>ar", "<cmd>CodeCompanion /refactor<cr>", mode = "v", desc = "AI: Refactor code" },
		{ "<leader>at", "<cmd>CodeCompanion /tests<cr>", mode = "v", desc = "AI: Generate tests" },
		{ "<leader>ad", "<cmd>CodeCompanion /doc<cr>", mode = "v", desc = "AI: Add documentation" },
		{ "<leader>ai", "<cmd>CodeCompanion<cr>", desc = "AI: Inline prompt" },
	},
	opts = function()
		return require("configs.codecompanion")
	end,
	config = true,
}
