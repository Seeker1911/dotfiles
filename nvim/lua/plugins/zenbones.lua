return {
	"zenbones-theme/zenbones.nvim",
	-- Optionally install Lush. Allows for more configuration or extending the colorscheme
	-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
	-- In Vim, compat mode is turned on as Lush only works in Neovim.
	dependencies = "rktjmp/lush.nvim",
	lazy = false,
	priority = 1000,
	-- I like zenburned, kanagawabones, & zenwritten to look like a newspaper
	-- you can set set configuration options here
	-- config = function()
	--     vim.g.zenbones_darken_comments = 45
	--     vim.cmd.colorscheme('zenbones')
	-- end
}
