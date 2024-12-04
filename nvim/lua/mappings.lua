require("nvchad.mappings")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<SPACE>", "za", { desc = "toggle current fold" })
map("i", "jj", "<ESC>")
map("t", "<ESC>", [[<C-\><C-n>]], { desc = "Enter Normal mode in terminal" })

map({ "n", "t" }, "<Esc>i", function()
	require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "terminal toggle floating term" })

map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
