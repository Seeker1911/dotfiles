-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(
---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "github_light",
	-- Other configurations...
}

M.ui = {
	cmp = {
		lspkind_text = true,
		style = "default",
		format_colors = {
			tailwind = false,
		},
	},
	statusline = {
		theme = "minimal",
		separator_style = "default",
	},
}

return M
