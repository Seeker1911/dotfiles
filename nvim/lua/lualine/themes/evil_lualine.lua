local colors = {
	bg = "#202328",
	fg = "#bbc2cf",
	yellow = "#ECBE7B",
	cyan = "#008080",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}

return {
	normal = {
		a = { bg = "None", fg = colors.red, gui = "bold" },
		b = { bg = "None", fg = colors.fg },
		c = { bg = "None", fg = colors.fg },
	},
	insert = {
		a = { bg = "None", fg = colors.green, gui = "bold" },
		b = { bg = "None", fg = colors.fg },
		c = { bg = "None", fg = colors.fg },
	},
	visual = {
		a = { bg = "None", fg = colors.blue, gui = "bold" },
		b = { bg = "None", fg = colors.fg },
		c = { bg = "None", fg = colors.fg },
	},
	replace = {
		a = { bg = "None", fg = colors.violet, gui = "bold" },
		b = { bg = "None", fg = colors.fg },
		c = { bg = "None", fg = colors.fg },
	},
	command = {
		a = { bg = "None", fg = colors.magenta, gui = "bold" },
		b = { bg = "None", fg = colors.fg },
		c = { bg = "None", fg = colors.fg },
	},
	terminal = {
		a = { bg = "None", fg = colors.cyan, gui = "bold" },
		b = { bg = "None", fg = colors.fg },
		c = { bg = "None", fg = colors.fg },
	},
	inactive = {
		a = { bg = "None", fg = colors.fg, gui = "bold" },
		b = { bg = "None", fg = colors.fg },
		c = { bg = "None", fg = colors.fg },
	},
}
