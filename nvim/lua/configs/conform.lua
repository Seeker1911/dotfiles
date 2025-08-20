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

	formatters = {
		ruff_fix = {
			command = "/opt/homebrew/bin/ruff",
			args = { "check", "--fix", "--stdin-filename", "$FILENAME", "-" },
			stdin = true,
		},
		ruff_format = {
			command = "/opt/homebrew/bin/ruff",
			args = { "format", "--stdin-filename", "$FILENAME", "-" },
			stdin = true,
		},
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 5000,
		lsp_fallback = true,
	},
}

return options
