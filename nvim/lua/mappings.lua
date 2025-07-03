local map = vim.keymap.set
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "copy whole file" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

-- move linespace
-- map("n", "J", ":m '>+1<CR>gv=gv")

--search with cursor in middle
map("n", "n", "nzzzv", { desc = "search next" })
map("n", "N", "Nzzzv", { desc = "search previous" })

map("n", "<leader>fm", function()
	require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })

map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })

-- lazygit
map("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "open lazygit" })

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
	"n",
	"<leader>fa",
	"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
	{ desc = "telescope find all files" }
)

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

map({ "n", "t" }, "<Esc>i", function()
	require("configs.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "terminal toggle floating term" })

vim.api.nvim_create_autocmd("TermEnter", {
	callback = function()
		-- If the terminal window is lazygit, we do not make changes to avoid clashes
		if string.find(vim.api.nvim_buf_get_name(0), "lazygit") then
			return
		end
		vim.keymap.set("t", "<ESC>", function()
			vim.cmd("stopinsert")
		end, { buffer = true })
	end,
})

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
	vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "whichkey query lookup" })

map("n", "<SPACE>", "za", { desc = "toggle current fold" })
map("i", "jj", "<ESC>")
map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "open diagnostic float" })

vim.keymap.set("n", "<leader>rt", function()
	local file = vim.fn.expand("%")
	local cur_ft = vim.bo.filetype

	local runners = {
		javascript = "npm test " .. file,
		typescript = "pnpm ts " .. file,
	}

	local cmd = runners[cur_ft]
	if not cmd then
		vim.notify("no runner for " .. cur_ft, vim.log.levels.ERROR)
		return
	end

	vim.cmd("vsplit") -- open vertical split
	vim.cmd("terminal " .. cmd) -- run command in terminal
	vim.cmd("startinsert") -- enter insert mode
end, { desc = "run open typescript/javascript file" })

vim.keymap.set("n", "<C-t>", function()
	require("menu").open("default")
end, {})

-- mouse users + nvimtree users!
vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
	require("menu.utils").delete_old_menus()

	vim.cmd.exec('"normal! \\<RightMouse>"')

	-- clicked buf
	local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
	local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

	require("menu").open(options, { mouse = true })
end, {})

-- map("n", "<leader>ft", function()
-- 	require("nvchad.term").new({ pos = "float" })
-- end, { desc = "terminal new float term" })

-- adjust splits
map("n", "<M-,>", "<c-w>5<")
map("n", "<M-.>", "<c-w>5>")
map("n", "<M-t>", "<c-w>5+")
map("n", "<M-s>", "<c-w>5-")

vim.api.nvim_set_keymap("n", "<leader>tt", ":CyberdreamToggleMode<CR>", { noremap = true, silent = true })

map("n", "<leader>tcd", function()
	-- Paths to the theme files
	local dark_theme = "~/.config/alacritty/themes/themes/cyberdream.toml"
	local light_theme = "~/.config/alacritty/themes/themes/cyberdream-light.toml"

	-- Determine current background and toggle
	local current_background = vim.o.background
	local command

	if current_background == "dark" then
		command = string.format("echo \"general.import = ['%s']\" > ~/.alacritty_background.toml", light_theme)
		vim.o.background = "light"
	else
		command = string.format("echo \"general.import = ['%s']\" > ~/.alacritty_background.toml", dark_theme)
		vim.o.background = "dark"
	end

	-- Execute the shell command to update Alacritty theme
	os.execute(command)

	-- Call the :CyberdreamToggleMode Vim command
	vim.cmd("CyberdreamToggleMode")

	-- Notify the user
	print("Switched background to " .. vim.o.background .. " mode")
end, { desc = "buffer goto next" })

function InsertConsoleLog()
	vim.api.nvim_feedkeys("i const log = (x: any) => { console.log(`🚨 🚨: `, x); return x }", "n", false)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end
-- Map a key to the function (e.g., <Leader>l for leader key + l)
vim.api.nvim_set_keymap("n", "<Leader>l", ":lua InsertConsoleLog()<CR>", { noremap = true, silent = true })
