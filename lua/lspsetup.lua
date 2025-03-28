require("cmpsetup")
-- require('nls')

vim.api.nvim_create_autocmd("User", {
	pattern = "LspAttached",
	desc = "LSP actions",
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			local opts = { buffer = true }
			vim.keymap.set(mode, lhs, rhs, opts)
		end
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
		bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
		-- bufmap('n', 'K', '<cmd>Lspsaga hover_doc<cr>')
		-- bufmap('n', 'gd', '<cmd>Lspsaga goto_definition<cr>')
		bufmap("n", "gp", "<cmd>Lspsaga peek_definition<cr>")
		bufmap("n", "go", "<cmd>Lspsaga peek_type_definition<cr>")
		bufmap("n", "gO", "<cmd>Lspsaga goto_type_definition<cr>")
		-- bufmap('n', 'gf', '<cmd>Lspsaga finder def+ref+imp<cr>')
		bufmap("n", "gF", "<cmd>Lspsaga finder tyd+def+ref<cr>")
		bufmap("n", "gw", "<cmd>Lspsaga term_toggle<cr>")
		bufmap("n", "gD", "<cmd>Trouble diagnostics<cr>")
		bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
		bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
		bufmap("n", "gR", "<cmd>Trouble lsp_references<cr>")
		bufmap("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
		bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
		bufmap("n", "gL", "<cmd>Trouble diagnostics<cr>")
		bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
		bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
		bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
		bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
		bufmap("x", "<F4>", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")
		bufmap("n", "<F5>", "<cmd>lua vim.lsp.buf.format()<cr>")
		bufmap("n", "<F6>", "<cmd>lua vim.diagnostic.hide()<cr>")
		bufmap("n", "<F7>", "<cmd>lua vim.diagnostic.show()<cr>")
		bufmap("n", "<F8>", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
		bufmap("n", "<F9>", "<cmd>EslintFixAll()<cr>")
	end,
})

---
-- Diagnostics
---
local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = opts.name,
	})
end
sign({ name = "DiagnosticSignError", text = "✘" })
-- sign({ name = 'DiagnosticSignError', text = 'ﮊ' })
sign({ name = "DiagnosticSignWarn", text = " " })
sign({ name = "DiagnosticSignHint", text = " " })
sign({ name = "DiagnosticSignInfo", text = "" })

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	severity_sort = false,
	update_in_insert = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
	close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp_defaults = {
	flags = {
		debounce_text_changes = 1000,
		allow_incremental_sync = true,
	},
	capabilities = capabilities,
	vim.lsp.protocol.make_client_capabilities(),
	on_attach = function(client, bufnr)
		vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })

		-- if client.resolved_capabilities.document_formatting then
		--   local au_lsp = vim.api.nvim_create_augroup("eslint_lsp", { clear = true })
		--   vim.api.nvim_create_autocmd("BufWritePre", {
		--     pattern = "*",
		--     callback = function()
		--       vim.lsp.buf.formatting_sync()
		--     end,
		--     group = au_lsp,
		--   })
		-- end

		vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "TextChangedP" }, {
			pattern = { "*.js", "*.ts", "*.svelte" },
			callback = function(ctx)
				if client.name == "svelte" then
					client.notify("$/onDidChangeTsOrJsFile", {
						uri = ctx.match,
						changes = {
							{ text = table.concat(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false), "\n") },
						},
					})

					vim.api.nvim_create_autocmd("BufWritePost", {
						pattern = { "*.js", "*.ts" },
						group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
						callback = function(ctx)
							-- Here use ctx.match instead of ctx.file
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
						end,
					})
				end
			end,
			group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
		})
	end,
}

require("mason").setup({
	PATH = "append",
	pip = { upgrade_pip = true },
})
local lspconfig = require("lspconfig")

lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_defaults)
lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, capabilities)

---
-- Mason Config
---
local mason_lspconfig = require("mason-lspconfig")
-- ToInstall = { "rust_analyzer", "gopls", "ts_ls", "terraformls", "lua_ls", "ruff", "pylsp", "eslint" }
ToInstall =
	{ "rust_analyzer", "gopls", "terraformls", "ts_ls", "lua_ls", "ruff", "pylsp", "eslint", "svelte", "phpactor" }
mason_lspconfig.setup({
	ensure_installed = ToInstall,
	automatic_installation = true,
	on_attach = lsp_defaults.on_attach,
	capabilities = lsp_defaults.capabilities,
})

-- AcceptDefaults = { "rust_analyzer", "gopls", "terraformls", "lua_ls", "jedi_language_server"}
-- AcceptDefaults = { "rust_analyzer", "gopls", "terraformls", "svelte", "ts_ls"}
AcceptDefaults = { "rust_analyzer", "gopls", "terraformls" }
for _, lsp in pairs(AcceptDefaults) do
	if lsp == "ts_ls" then
		-- handled by typescript-tools
		return
	end
	lspconfig[lsp].setup({
		on_attach = lsp_defaults.on_attach,
		capabilities = lsp_defaults.capabilities,
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
	on_attach = lsp_defaults.on_attach,
	capabilities = lsp_defaults.capabilities,
	init_options = {
		-- these aren't working: https://github.com/sveltejs/language-tools/tree/master/packages/language-server
		svelte = {
			plugin = {
				typescript = {
					enable = true,
					completions = { enable = true },
				},
			},
		},
	},
})

lspconfig.ruff.setup({
	enabled = true,
	on_attach = lsp_defaults.on_attach,
	capabilities = lsp_defaults.capabilities,
	init_options = {
		settings = {
			-- Any extra CLI arguments for `ruff` go here.
			-- LSP server doesn't pick up changes from this pattern
			args = {
				"--config=" .. vim.loop.os_homedir() .. "/.config/ruff/pyproject.toml",
			},
			fixAll = true,
		},
	},
})

local lua_rtp = vim.split(package.path, ";")
table.insert(lua_rtp, "lua/?.lua")
table.insert(lua_rtp, "lua/?/init.lua")

lspconfig.lua_ls.setup({
	on_attach = lsp_defaults.on_attach,
	capabilities = lsp_defaults.capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = lua_rtp,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

lspconfig.pylsp.setup({
	-- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
	enabled = true,
	on_attach = lsp_defaults.on_attach,
	capabilities = lsp_defaults.capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
	settings = {
		pylsp = {
			plugins = {
				ruff = {
					enabled = false,
					args = { "--config ~/.config/ruff/pyproject.toml" },
				},
				pycodestyle = {
					enabled = false,
					ignore = {},
					maxLineLength = 100,
				},
				flake8 = {
					enabled = false,
					ignore = {},
					indentSize = 4,
					maxLineLength = 100,
				},
				pyflakes = {
					enabled = false,
					ignore = {},
					indentSize = 4,
					maxLineLength = 100,
				},
				pylint = {
					enabled = false,
					maxLineLength = 100,
					args = { "--rcfile ~/.config/pylintrc" },
				},
			},
		},
	},
})

lspconfig.eslint.setup({
	enabled = true,
	capabilities = lsp_defaults.capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,

	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})

local api = require("typescript-tools.api")
require("typescript-tools").setup({
	on_attach = lsp_defaults.on_attach,
	capabilities = lsp_defaults.capabilities,
	enabled = false,
	handlers = {
		["textDocument/publishDiagnostics"] = api.filter_diagnostics(
			-- Ignore errors by number
			{}
		),
	},
	settings = {
		tsserver_plugins = {
			-- for TypeScript v4.9+
			"@styled/typescript-styled-plugin",
		},
		-- spawn additional tsserver instance to calculate diagnostics on it
		separate_diagnostic_server = false,
		-- "change"|"insert_leave" determine when the client asks the server about diagnostic
		publish_diagnostic_on = "insert_leave",
		-- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
		-- "remove_unused_imports"|"organize_imports") -- or string "all"
		-- to include all supported code actions
		-- specify commands exposed as code_actions
		expose_as_code_action = { "all" },
		-- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
		-- not exists then standard path resolution strategy is applied
		tsserver_path = nil,
		-- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
		-- memory limit in megabytes or "auto"(basically no limit)
		tsserver_max_memory = "auto",
		-- described below
		--
		-- format options and file preferences for typescript-server
		-- https://github.com/microsoft/TypeScript/blob/3b45f4db12bbae97d10f62ec0e2d94858252c5ab/src/server/protocol.ts#L3418
		tsserver_format_options = {
			insertSpaceBeforeAndAfterBinaryOperators = true,
			semicolons = "ignore",
			-- allowIncompleteCompletions = false,
			allowRenameOfImportPath = true,
		},
		tsserver_file_preferences = {
			includeInlayParameterNameHints = "all",
			includeInlayFunctionParameterTypeHints = true,
			includeCompletionsForModuleExports = true,
			includeCompletionsForImportStatements = true,
			includeAutomaticOptionalChainCompletions = true,
			includePackageJsonAutoImports = true,
			displayPartsForJSDoc = true,
			quotePreference = "single",
			disableSuggestions = false,
		},
		-- locale of all tsserver messages, supported locales you can find here:
		-- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
		tsserver_locale = "en",
		-- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
		complete_function_calls = true,
		include_completions_with_insert_text = true,
		-- CodeLens
		-- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
		-- possible values: ("off"|"all"|"implementations_only"|"references_only")
		code_lens = "all",
		-- by default code lenses are displayed on all referencable values and for some of you it can
		-- be too much this option reduce count of them by removing member references from lenses
		disable_member_code_lens = true,
		-- JSXCloseTag
		-- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
		-- that maybe have a conflict if enable this feature. )
		jsx_close_tag = {
			enable = false,
			filetypes = { "javascriptreact", "typescriptreact" },
		},
	},
})

-- lspconfig.ts_ls.setup {
--   on_attach = lsp_defaults.on_attach,
--   capabilities = lsp_defaults.capabilities,
--   -- Ensure the server is looking for the nearest tsconfig.json or jsconfig.json
--   root_dir = lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", ".git"),
--   -- Custom handler configurations can be set here as needed
--   settings = {
--     -- Add any specific settings for ts_ls or plugins here
--     }
--   }

lspconfig.phpactor.setup({
	on_attach = lsp_defaults.on_attach,
	init_options = {
		["language_server_phpstan.enabled"] = false,
		["language_server_psalm.enabled"] = false,
	},
})
