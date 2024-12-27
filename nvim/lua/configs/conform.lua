local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		typescript = { "eslint" },
		javascript = { "eslint_d" },
		svelte = { "eslint_d" },
		python = { "ruff" },
		css = { "prettierd", "prettier" },
		html = { "prettierd", "prettier" },
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
}

return options
