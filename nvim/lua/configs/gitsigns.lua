return {
	signs = {
		delete = { text = "󰍵" },
		changedelete = { text = "󱕖" },
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "Gitsigns: Next hunk" })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "Gitsigns: Previous hunk" })

		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Gitsigns: Select hunk" })
	end,
}
