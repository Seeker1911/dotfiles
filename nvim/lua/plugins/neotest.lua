return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-jest",
		"marilari88/neotest-vitest",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python"),
				require("neotest-jest")({}),
				require("neotest-vitest"),
			},
		})
	end,
	keys = {
		{ "<leader>Tt", function() require("neotest").run.run() end, desc = "Neotest: Nearest test" },
		{ "<leader>Tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Neotest: File" },
		{ "<leader>Ts", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Neotest: Suite" },
		{ "<leader>Tl", function() require("neotest").run.run_last() end, desc = "Neotest: Last" },
		{ "<leader>Tx", function() require("neotest").run.stop() end, desc = "Neotest: Stop" },
		{ "<leader>To", function() require("neotest").output.open({ enter = true }) end, desc = "Neotest: Output" },
		{ "<leader>TO", function() require("neotest").output_panel.toggle() end, desc = "Neotest: Output panel" },
		{ "<leader>TS", function() require("neotest").summary.toggle() end, desc = "Neotest: Summary" },
		{ "<leader>Tw", function() require("neotest").watch.toggle() end, desc = "Neotest: Watch file" },
		{ "]t", function() require("neotest").jump.next({ status = "failed" }) end, desc = "Next failed test" },
		{ "[t", function() require("neotest").jump.prev({ status = "failed" }) end, desc = "Previous failed test" },
	},
}
