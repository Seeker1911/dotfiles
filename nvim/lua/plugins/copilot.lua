-- return {
-- 	"github/copilot.vim",
-- 	lazy = true,
-- 	cmd = "Copilot",
-- 	-- enable = false,
-- 	-- event = "UIEnter",
-- }
return {
	"github/copilot.vim",
	lazy = true,
	cmd = "Copilot",
	config = function()
		-- Remap accept key to `<Right>`
		vim.g.copilot_no_tab_map = true
		vim.api.nvim_set_keymap(
			"i",
			"<Right>",
			'copilot#Accept("<CR>")',
			{ silent = true, expr = true, noremap = true }
		)
	end,
}
