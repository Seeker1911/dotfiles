require("nvchad.mappings")

local map = vim.keymap.set

map("n", "<SPACE>", "za", { desc = "toggle current fold" })
map("i", "jj", "<ESC>")
map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "open diagnostic float" })

vim.api.nvim_set_keymap("n", "<leader>tt", ":CyberdreamToggleMode<CR>", { noremap = true, silent = true })

map({ "n", "t" }, "<Esc>i", function()
	require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "terminal toggle floating term" })

map("n", "<leader>rt", function()
	local file = vim.fn.expand("%")
	local cur_ft = vim.bo.ft

	local fts = {
		-- javascript = "pnpm ts " .. file,
		typescript = "pnpm ts " .. file,
	}

	if not fts[cur_ft] then
		vim.notify("no runner for " .. cur_ft, vim.log.levels.ERROR)
		return
	end

	require("nvchad.term").runner({
		pos = "vsp",
		cmd = fts[cur_ft],
		id = "test code runner",
	})
end, { desc = "run open typescript file" })

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

map("n", "<leader>ft", function()
	require("nvchad.term").new({ pos = "float" })
end, { desc = "terminal new float term" })

-- adjust splits
map("n", "<M-,>", "<c-w>5<")
map("n", "<M-.>", "<c-w>5>")
map("n", "<M-t>", "<c-w>5+")
map("n", "<M-s>", "<c-w>5-")
