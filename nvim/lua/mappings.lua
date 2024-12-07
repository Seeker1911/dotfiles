require("nvchad.mappings")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<SPACE>", "za", { desc = "toggle current fold" })
map("i", "jj", "<ESC>")
map("t", "<ESC>", [[<C-\><C-n>]], { desc = "Enter Normal mode in terminal" })
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
