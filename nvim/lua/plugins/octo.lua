return {
	"pwntester/octo.nvim",
	-- event = "UIEnter",
	cmd = "Octo",
	enabled = false,
	opts = {},
	-- requires = {
	-- 	"nvim-lua/plenary.nvim",
	-- 	"nvim-telescope/telescope.nvim",
	-- 	-- OR 'ibhagwan/fzf-lua',
	-- 	"nvim-tree/nvim-web-devicons",
	-- },
	config = function()
		require("octo").setup()
	end,
}
