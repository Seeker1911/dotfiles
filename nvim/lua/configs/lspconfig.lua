local M = {}
local map = vim.keymap.set

local lspconfig = require("lspconfig")
local servers = { "html", "ts_ls", "eslint", "svelte", "ruff", "pylsp" }
-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP " .. desc }
	end

	map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
	map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
	map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
	map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))

	map("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts("List workspace folders"))

	map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
	-- map("n", "<leader>ra", require("configs.renamer"), opts("Renamer"))
	vim.keymap.set("n", "<leader>rn", function()
		return ":IncRename " .. vim.fn.expand("<cword>")
	end, { expr = true })

	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
	
	-- Python-specific ruff code actions
	if vim.bo.filetype == "python" then
		map("n", "<leader>ra", function()
			vim.lsp.buf.code_action({
				filter = function(action)
					return action.kind and string.match(action.kind, "quickfix")
				end,
				apply = true,
			})
		end, opts("Ruff auto-fix"))
	end
	map("n", "gr", vim.lsp.buf.references, opts("Show references"))
end

-- disable semanticTokens
M.on_init = function(client, _)
	if client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

M.defaults = function()
	require("configs.lspDiagnostic").diagnostic_config()
	vim.lsp.set_log_level("WARN")
	require("lspconfig").lua_ls.setup({
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,

		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
						vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
						vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
						"${3rd}/luv/library",
					},
					maxPreload = 100000,
					preloadFileSize = 10000,
				},
			},
		},
	})

	-- lsps with default config
	for _, lsp in ipairs(servers) do
		lspconfig[lsp].setup({
			on_attach = M.on_attach,
			on_init = M.on_init,
			capabilities = M.capabilities,
		})
	end

	lspconfig.svelte.setup({
		-- requires: npm install --save-dev typescript-svelte-plugin on per project basis
		filetypes = { "svelte" },
		pattern = { "*.svelte" },
		enabled = true,
		root_dir = function()
			return vim.loop.cwd()
		end,
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
		settings = {
			-- these aren't working: https://github.com/sveltejs/language-tools/tree/master/packages/language-server
			svelte = {
				plugin = {
					typescript = {
						enable = true,
						hover = { enable = true },
						completions = { enable = true },
					},
					svelte = {
						format = {
							enable = false,
							config = { singleQuote = true, printWidth = 160 },
						},
					},
				},
			},
		},
	})
	lspconfig.ruff.setup({
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
		filetypes = { "python" },
		cmd = { "/opt/homebrew/bin/ruff", "server", "--preview" },
		root_dir = require("lspconfig").util.find_git_ancestor,
		init_options = {
			settings = {
				configuration = vim.fn.expand("~/.config/ruff/pyproject.toml"),
				configurationPreference = "filesystemFirst",
			},
		},
	})

	lspconfig.pylsp.setup({
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
		filetypes = { "python" },
		settings = {
			pylsp = {
				plugins = {
					pycodestyle = { enabled = false },
					pyflakes = { enabled = false },
					pylint = { enabled = false },
					flake8 = { enabled = false },
					mccabe = { enabled = false },
					autopep8 = { enabled = false },
					yapf = { enabled = false },
					rope_autoimport = { enabled = true },
					rope_completion = { enabled = true },
				},
			},
		},
	})

	lspconfig.eslint.setup({
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
		flags = {
			allow_incremental_sync = true,
			template_curly_spacing = false,
			debounce_text_changes = 1000,
		},
	})
end
return M
