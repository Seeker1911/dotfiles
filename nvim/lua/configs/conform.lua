local prettier = { "prettierd", "prettier", stop_after_first = true }

-- Only format with prettier in projects that opted into it
local formatters = {
	prettierd = { require_cwd = true },
	prettier = { require_cwd = true },
}

local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		typescript = { "eslint_d", "prettierd" },
		typescriptreact = { "eslint_d", "prettierd" },
		javascript = { "eslint_d", "prettierd" },
		javascriptreact = { "eslint_d", "prettierd" },
		svelte = { "eslint_d", "prettierd" },
		python = { "ruff_fix", "ruff_format" },
		css = prettier,
		html = prettier,
		json = prettier,
		jsonc = prettier,
		yaml = prettier,
		markdown = prettier,
	},

	formatters = formatters,

	format_on_save = {
		timeout_ms = 5000,
		lsp_format = "fallback",
	},
}

return options
