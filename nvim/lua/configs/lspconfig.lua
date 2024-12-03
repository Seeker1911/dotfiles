-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")

local servers = { "html", "ts_ls", "eslint", "svelte", "ruff" }
local nvlsp = require("nvchad.configs.lspconfig")

-- lsps with default config
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = nvlsp.on_attach,
		on_init = nvlsp.on_init,
		capabilities = nvlsp.capabilities,
	})
end

-- configuring single server, example: typescript
-- lspconfig.svelte.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   settings = {
--     svelte = {
--       plugin = {
--         svelte = true,
--         typescript = true,
--         javascript = true,
--       },
--     },
--   },
-- }

lspconfig.svelte.setup({
	-- requires: npm install --save-dev typescript-svelte-plugin on per project basis
	filetypes = { "svelte" },
	pattern = { "*.svelte" },
	enabled = true,
	root_dir = function()
		return vim.loop.cwd()
	end,
	on_attach = nvlsp.on_attach(),
	capabilities = nvlsp.capabilities,
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
