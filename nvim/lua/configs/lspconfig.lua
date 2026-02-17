local M = {}
local map = vim.keymap.set

local servers = { "html", "ts_ls", "eslint", "ruff", "basedpyright" }

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP: " .. desc }
	end

	-- Navigation (standard vim keys)
	map("n", "gD", vim.lsp.buf.declaration, opts("Declaration"))
	map("n", "gd", vim.lsp.buf.definition, opts("Definition"))
	map("n", "gi", vim.lsp.buf.implementation, opts("Implementation"))
	map("n", "gr", vim.lsp.buf.references, opts("References"))
	map("n", "K", vim.lsp.buf.hover, opts("Hover"))

	-- LSP actions (,l prefix)
	map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts("Code action"))
	map("n", "<leader>lr", function()
		return ":IncRename " .. vim.fn.expand("<cword>")
	end, { buffer = bufnr, expr = true, desc = "LSP: Rename" })
	map("n", "<leader>ls", vim.lsp.buf.signature_help, opts("Signature help"))
	map("n", "<leader>lD", vim.lsp.buf.type_definition, opts("Type definition"))
	map("n", "<leader>lh", vim.lsp.buf.hover, opts("Hover"))
	map("n", "<leader>lf", function()
		vim.lsp.buf.format({ async = true })
	end, opts("Format"))
	map("n", "<leader>li", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end, opts("Toggle inlay hints"))
	map("n", "<leader>lk", function()
		vim.diagnostic.open_float({ scope = "cursor" })
	end, opts("Hover diagnostic"))

	-- Workspace (,lw prefix)
	map("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
	map("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
	map("n", "<leader>lwl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts("List workspace folders"))

	-- Python-specific ruff code actions (keep under ,r for Ruff)
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
end

-- disable semanticTokens
M.on_init = function(client, _)
	if client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

M.capabilities = require("blink.cmp").get_lsp_capabilities()

M.defaults = function()
	require("configs.lspDiagnostic").diagnostic_config()
	vim.lsp.set_log_level("WARN")

	-- Configure lua_ls
	vim.lsp.config("lua_ls", {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
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

	-- Configure HTML LSP
	vim.lsp.config("html", {
		cmd = { "vscode-html-language-server", "--stdio" },
		filetypes = { "html" },
		root_markers = { ".git" },
		on_attach = M.on_attach,
		on_init = M.on_init,
		capabilities = M.capabilities,
	})

	-- Configure TypeScript LSP
	vim.lsp.config("ts_ls", {
		cmd = { "typescript-language-server", "--stdio" },
		filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
		root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
		on_attach = M.on_attach,
		on_init = M.on_init,
		capabilities = M.capabilities,
		settings = {
			typescript = {
				preferences = {
					semicolons = "remove",
					includePackageJsonAutoImports = "on",
					includeCompletionsForImportStatements = true,
					includeCompletionsWithSnippetText = true,
				},
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
			javascript = {
				preferences = {
					semicolons = "remove",
					includePackageJsonAutoImports = "on",
					includeCompletionsForImportStatements = true,
					includeCompletionsWithSnippetText = true,
				},
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	})

	-- Configure ESLint
	vim.lsp.config("eslint", {
		cmd = { "vscode-eslint-language-server", "--stdio" },
		filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte" },
		root_markers = { ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json", "package.json", ".git" },
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
		settings = {
			codeAction = {
				disableRuleComment = {
					enable = true,
					location = "separateLine",
				},
				showDocumentation = {
					enable = true,
				},
			},
			codeActionOnSave = {
				enable = false,
				mode = "all",
			},
			format = true,
			nodePath = "",
			onIgnoredFiles = "off",
			packageManager = "npm",
			quiet = false,
			rulesCustomizations = {},
			run = "onType",
			useESLintClass = false,
			validate = "on",
			workingDirectory = {
				mode = "location",
			},
		},
	})

	-- Configure Svelte
	vim.lsp.config("svelte", {
		cmd = { "svelteserver", "--stdio" },
		filetypes = { "svelte" },
		root_markers = { "package.json", ".git" },
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
		settings = {
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

	-- Configure Ruff (linting + formatting, defer hover to basedpyright)
	vim.lsp.config("ruff", {
		cmd = { "ruff", "server", "--preview" },
		filetypes = { "python" },
		root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
		on_attach = function(client, bufnr)
			client.server_capabilities.hoverProvider = false
			M.on_attach(client, bufnr)
		end,
		capabilities = M.capabilities,
		on_init = M.on_init,
		settings = {
			configuration = vim.fn.expand((os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config") .. "/ruff/pyproject.toml"),
			configurationPreference = "filesystemFirst",
		},
	})

	-- Configure basedpyright (type checking, completions, auto-imports, hover)
	vim.lsp.config("basedpyright", {
		cmd = { "basedpyright-langserver", "--stdio" },
		filetypes = { "python" },
		root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
		settings = {
			basedpyright = {
				analysis = {
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					diagnosticMode = "openFilesOnly",
				},
			},
		},
	})

	-- Enable the LSP servers for relevant filetypes
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "lua", "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "python" },
		callback = function(args)
			local bufnr = args.buf
			local clients = vim.lsp.get_clients({ bufnr = bufnr })

			-- Map filetypes to LSP server names
			local filetype_to_servers = {
				lua = { "lua_ls" },
				html = { "html" },
				javascript = { "ts_ls", "eslint" },
				javascriptreact = { "ts_ls", "eslint" },
				typescript = { "ts_ls", "eslint" },
				typescriptreact = { "ts_ls", "eslint" },
				svelte = { "svelte", "eslint" },
				python = { "ruff", "basedpyright" },
			}

			local servers_for_ft = filetype_to_servers[vim.bo[bufnr].filetype] or {}

			for _, server_name in ipairs(servers_for_ft) do
				-- Check if this server is already attached
				local already_attached = false
				for _, client in ipairs(clients) do
					if client.name == server_name then
						already_attached = true
						break
					end
				end

				if not already_attached then
					vim.lsp.enable(server_name)
				end
			end
		end,
	})
end
return M
