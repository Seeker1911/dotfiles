local colors = require("cyberdream.colors").light

return {
	normal = {
		a = { bg = "None", fg = colors.blue, gui = "bold" },
		b = { bg = "None", fg = colors.grey },
		c = { bg = "None", fg = colors.grey },
	},
	insert = {
		a = { bg = "None", fg = colors.green, gui = "bold" },
		b = { bg = "None", fg = colors.grey },
		c = { bg = "None", fg = colors.grey },
	},
	visual = {
		a = { bg = "None", fg = colors.yellow, gui = "bold" },
		b = { bg = "None", fg = colors.grey },
		c = { bg = "None", fg = colors.grey },
	},
	replace = {
		a = { bg = "None", fg = colors.red, gui = "bold" },
		b = { bg = "None", fg = colors.grey },
		c = { bg = "None", fg = colors.grey },
	},
	command = {
		a = { bg = "None", fg = colors.purple, gui = "bold" },
		b = { bg = "None", fg = colors.grey },
		c = { bg = "None", fg = colors.grey },
	},
	terminal = {
		a = { bg = "None", fg = colors.cyan, gui = "bold" },
		b = { bg = "None", fg = colors.grey },
		c = { bg = "None", fg = colors.grey },
	},
	inactive = {
		a = { bg = "None", fg = colors.grey, gui = "bold" },
		b = { bg = "None", fg = colors.grey },
		c = { bg = "None", fg = colors.grey },
	},
}
