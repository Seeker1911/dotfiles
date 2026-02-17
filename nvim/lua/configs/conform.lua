local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		typescript = { "eslint_d" },
		javascript = { "eslint_d" },
		svelte = { "eslint_d" },
		python = { "ruff_fix", "ruff_format" },
		css = { "prettierd", "prettier" },
		html = { "prettierd", "prettier" },
	},

	format_on_save = {
		timeout_ms = 5000,
		lsp_fallback = true,
	},
}

return options
