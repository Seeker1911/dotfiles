local autocmd = vim.api.nvim_create_autocmd

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
	callback = function(args)
		local file = vim.api.nvim_buf_get_name(args.buf)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

		if not vim.g.ui_entered and args.event == "UIEnter" then
			vim.g.ui_entered = true
		end

		if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
			vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
			vim.api.nvim_del_augroup_by_name("NvFilePost")

			vim.schedule(function()
				vim.api.nvim_exec_autocmds("FileType", {})

				if vim.g.editorconfig then
					require("editorconfig").config(args.buf)
				end
			end)
		end
	end,
})

vim.api.nvim_create_user_command("DismissNotify", function()
	require("notify").dismiss({ silent = true, pending = true })
end, {})

vim.api.nvim_create_user_command("BdHidden", function()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.fn.bufwinnr(buf) == -1 then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end, {})

-- TypeScript/JavaScript specific indentation settings
autocmd("FileType", {
	pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact", "json", "jsonc" },
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
	end,
})

-- Python specific settings and auto-fix
autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.expandtab = true
		
		-- Auto-fix on save with ruff
		autocmd("BufWritePre", {
			buffer = 0,
			callback = function()
				require("conform").format({ 
					formatters = { "ruff_fix", "ruff_format" },
					timeout_ms = 3000,
				})
			end,
		})
	end,
})
