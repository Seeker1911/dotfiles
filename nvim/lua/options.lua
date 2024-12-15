require("nvchad.options")

-- add yours here!

local o = vim.o
local g = vim.g
-- o.cursorlineopt ='both' -- to enable cursorline!
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

g.vim_svelte_plugin_load_full_syntax = 1
g.vim_svelte_plugin_use_typescript = 1

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 1
vim.opt.foldminlines = 4
vim.opt.foldnestmax = 2
vim.opt.foldtext = ""

vim.api.nvim_create_autocmd({ "FileType" }, {
	callback = function()
		if require("nvim-treesitter.parsers").has_parser() then
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		else
			vim.opt.foldmethod = "syntax"
		end
	end,
})
