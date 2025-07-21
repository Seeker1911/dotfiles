local M = {}
local map = vim.keymap.set

local lspconfig = require("lspconfig")
local servers = { "html", "ts_ls", "eslint", "svelte", "ruff" }
-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP " .. desc }
	end

	map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
	map("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts("Peek definition"))
	map("n", "<leader>gd", "<cmd>Lspsaga goto_definition<CR>", opts("Go to definition"))
	map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
	map("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts("Show hover info"))
	map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))

	map("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts("List workspace folders"))

	map("n", "<leader>D", "<cmd>Lspsaga peek_type_definition<CR>", opts("Peek type definition"))
	map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts("Rename"))
	map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts("Code action"))
	map("n", "gr", "<cmd>Lspsaga finder<CR>", opts("Show references"))

	-- Lspsaga navigation
	map("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts("Toggle outline"))
	map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts("Previous diagnostic"))
	map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts("Next diagnostic"))
	map("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts("Show line diagnostics"))
	
	-- Telescope LSP pickers for better type browsing
	map("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<cr>", opts("Type definitions"))
	map("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", opts("References"))
	map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", opts("Document symbols"))
	map("n", "<leader>lw", "<cmd>Telescope lsp_workspace_symbols<cr>", opts("Workspace symbols"))
end

-- enable semanticTokens for enhanced type highlighting
M.on_init = function(client, _)
	-- semanticTokens enabled for better type highlighting
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- Enhanced hover capabilities for detailed type information
M.capabilities.textDocument.hover = {
	dynamicRegistration = true,
	contentFormat = { "markdown", "plaintext" },
}

-- Enhanced completion capabilities
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

	-- TypeScript LSP with enhanced settings for detailed type information
	lspconfig.ts_ls.setup({
		on_attach = M.on_attach,
		on_init = M.on_init,
		capabilities = M.capabilities,
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
				suggest = {
					includeCompletionsForModuleExports = true,
				},
				preferences = {
					displayPartsForJSDoc = true,
					includeCompletionsForModuleExports = true,
					includeCompletionsWithSnippetText = true,
					generateReturnInDocTemplate = true,
					includePackageJsonAutoImports = "auto",
				},
			},
			javascript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
				suggest = {
					includeCompletionsForModuleExports = true,
				},
				preferences = {
					displayPartsForJSDoc = true,
					includeCompletionsForModuleExports = true,
					includeCompletionsWithSnippetText = true,
					generateReturnInDocTemplate = true,
					includePackageJsonAutoImports = "auto",
				},
			},
		},
	})

	-- Other LSPs with default config
	local other_servers = { "html", "eslint", "svelte", "ruff" }
	for _, lsp in ipairs(other_servers) do
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
		root_dir = require("lspconfig").util.find_git_ancestor,
		init_options = {
			settings = {
				-- Customize settings if needed
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
