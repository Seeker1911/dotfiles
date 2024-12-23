local opt = vim.opt
local o = vim.o
local g = vim.g

local file_path = os.getenv("HOME") .. "/.alacritty_background.toml"
-- print("file path: ", file_path)

-- Read the file content
local content = ""
local file = io.open(file_path, "r")

-- print("file : ", file)
if file then
	content = file:read("*all")
	-- print("file exists , content: ", content)
	file:close()
end

-- Define the pattern to find the specific string
local pattern = "general%.import%s*=%s*%['~/.config/alacritty/themes/themes/(.*)%.toml'%]"

-- Search for the pattern in the content
local theme = content:match(pattern)
-- print("THEME: ", theme)

opt.background = "light"
local theme_name = "cyberdream"

if theme then
	if theme == "gruvbox_dark" then
		opt.background = "dark"
		theme_name = "gruvbox"
	elseif theme == "cyberdream" then
		opt.background = "light"
		theme_name = "cyberdream"
	elseif theme == "gruvbox_light" then
		opt.background = "light"
		theme_name = "gruvbox"
	end
end

-- print("Theme name: " .. (theme_name or "not found"))

vim.api.nvim_cmd({
	cmd = "colorscheme",
	args = { theme_name },
}, {})

-- nvim-tree options
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

opt.cursorlineopt = "line"
opt.cursorline = true

opt.termguicolors = true

o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

g.vim_svelte_plugin_load_full_syntax = 1
g.vim_svelte_plugin_use_typescript = 1

opt.foldlevel = 99
opt.foldlevelstart = 1
opt.foldminlines = 4
opt.foldnestmax = 2
opt.foldtext = ""

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

-------------------------------------- options ------------------------------------------
o.laststatus = 3
o.showmode = false

o.clipboard = "unnamedplus"
o.cursorlineopt = "number"

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = false

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH
