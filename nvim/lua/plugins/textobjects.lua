return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	event = "User FilePost",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	init = function()
		vim.g.no_python_maps = true
	end,
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = { lookahead = true },
			move = { set_jumps = true },
		})

		local select = require("nvim-treesitter-textobjects.select")
		local move = require("nvim-treesitter-textobjects.move")
		local swap = require("nvim-treesitter-textobjects.swap")
		local map = vim.keymap.set

		local objects = {
			f = { "@function.outer", "@function.inner", "Function" },
			c = { "@class.outer", "@class.inner", "Class" },
			a = { "@parameter.outer", "@parameter.inner", "Argument" },
			o = { "@loop.outer", "@loop.inner", "Loop" },
			i = { "@conditional.outer", "@conditional.inner", "Conditional" },
		}

		for key, spec in pairs(objects) do
			local outer, inner, label = spec[1], spec[2], spec[3]
			map({ "x", "o" }, "a" .. key, function()
				select.select_textobject(outer, "textobjects")
			end, { desc = "a " .. label })
			map({ "x", "o" }, "i" .. key, function()
				select.select_textobject(inner, "textobjects")
			end, { desc = "inner " .. label })
		end

		map({ "n", "x", "o" }, "]m", function()
			move.goto_next_start("@function.outer", "textobjects")
		end, { desc = "Next function" })
		map({ "n", "x", "o" }, "[m", function()
			move.goto_previous_start("@function.outer", "textobjects")
		end, { desc = "Previous function" })
		map({ "n", "x", "o" }, "]]", function()
			move.goto_next_start("@class.outer", "textobjects")
		end, { desc = "Next class" })
		map({ "n", "x", "o" }, "[[", function()
			move.goto_previous_start("@class.outer", "textobjects")
		end, { desc = "Previous class" })

		map("n", "<leader>cs", function()
			swap.swap_next("@parameter.inner")
		end, { desc = "Swap argument next" })
		map("n", "<leader>cS", function()
			swap.swap_previous("@parameter.inner")
		end, { desc = "Swap argument previous" })
	end,
}
