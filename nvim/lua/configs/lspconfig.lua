local M = {}
local map = vim.keymap.set

local servers = { "html", "ts_ls", "eslint", "ruff", "pylsp" }

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

	-- Register LSP-specific WhichKey groups dynamically
	if pcall(require, "which-key") then
		require("which-key").add({
			{ "<leader>s", group = "LSP", icon = "", buffer = bufnr },
			{ "<leader>sh", desc = "Signature help", buffer = bufnr },
		})
	end
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

	-- Helper function to find git root
	local function find_git_ancestor(path)
		local util = require("lspconfig.util")
		return util.find_git_ancestor(path)
	end

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
				},
			},
			javascript = {
				preferences = {
					semicolons = "remove",
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

	-- Configure Ruff
	vim.lsp.config("ruff", {
		cmd = { "ruff", "server", "--preview" },
		filetypes = { "python" },
		root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
		settings = {
			-- Use XDG_CONFIG_HOME or fallback to ~/.config
			configuration = vim.fn.expand((os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config") .. "/ruff/pyproject.toml"),
			configurationPreference = "filesystemFirst",
		},
	})

	-- Configure pylsp
	vim.lsp.config("pylsp", {
		cmd = { "pylsp" },
		filetypes = { "python" },
		root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		on_init = M.on_init,
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
				python = { "ruff", "pylsp" },
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
