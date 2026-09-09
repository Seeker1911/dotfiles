local ensure_installed = {
	"lua-language-server",
	"ruff",
	"ty",
	"typescript-language-server",
	"eslint-lsp",
	"html-lsp",
	"svelte-language-server",
	"yaml-language-server",
	"stylua",
	"eslint_d",
	"prettierd",
	"prettier",
}

vim.api.nvim_create_user_command("MasonInstallAll", function()
	local registry = require("mason-registry")
	local missing = vim.tbl_filter(function(name)
		return not registry.get_package(name):is_installed()
	end, ensure_installed)

	if #missing == 0 then
		vim.notify("mason: all packages installed", vim.log.levels.INFO)
		return
	end

	vim.cmd("MasonInstall " .. table.concat(missing, " "))
end, { desc = "Install every mason package this config expects" })

return {
	PATH = "skip",

	ui = {
		icons = {
			package_pending = " ",
			package_installed = " ",
			package_uninstalled = " ",
		},
	},

	max_concurrent_installers = 10,
}
