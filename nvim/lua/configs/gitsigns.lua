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

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "GitSigns: Jump to next hunk" })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "GitSigns: Jump to previous hunk" })

		-- Actions
		map("n", "<leader>hs", gs.stage_hunk, { desc = "GitSigns: Stage hunk" })
		map("n", "<leader>hr", gs.reset_hunk, { desc = "GitSigns: Reset hunk" })
		map("v", "<leader>hs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "GitSigns: Stage selected hunk" })
		map("v", "<leader>hr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "GitSigns: Reset selected hunk" })
		map("n", "<leader>hS", gs.stage_buffer, { desc = "GitSigns: Stage entire buffer" })
		map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "GitSigns: Undo stage hunk" })
		map("n", "<leader>hR", gs.reset_buffer, { desc = "GitSigns: Reset entire buffer" })
		map("n", "<leader>hp", gs.preview_hunk, { desc = "GitSigns: Preview hunk in float" })
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end, { desc = "GitSigns: Show blame for line" })
		map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "GitSigns: Toggle inline blame" })
		map("n", "<leader>hd", gs.diffthis, { desc = "GitSigns: Diff against index" })
		map("n", "<leader>hD", function()
			gs.diffthis("~")
		end, { desc = "GitSigns: Diff against last commit" })
		map("n", "<leader>td", gs.toggle_deleted, { desc = "GitSigns: Toggle deleted lines" })

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "GitSigns: Select hunk text object" })
	end,
}
