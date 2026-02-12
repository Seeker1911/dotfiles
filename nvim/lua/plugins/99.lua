return {
	"ThePrimeagen/99",
	keys = {
		{ "<leader>9f", function() require("99").fill_in_function() end, desc = "99: Fill function" },
		{ "<leader>9p", function() require("99").fill_in_function_prompt() end, desc = "99: Fill function (prompt)" },
		{ "<leader>9v", function() require("99").visual() end, mode = "v", desc = "99: Visual" },
		{ "<leader>9V", function() require("99").visual_prompt() end, mode = "v", desc = "99: Visual (prompt)" },
		{ "<leader>9s", function() require("99").stop_all_requests() end, desc = "99: Stop all" },
		{ "<leader>9l", function() require("99").view_logs() end, desc = "99: View logs" },
		{ "<leader>9i", function() require("99").info() end, desc = "99: Info" },
	},
	config = function()
		require("99").setup({
			model = "anthropic/claude-opus-4-6",
			md_files = { "AGENT.md", "CLAUDE.md" },
		})
	end,
}
