-- local runtime_path = vim.split(package.path, ';')
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- table.insert(runtime_path, 'lua/?.lua')
-- table.insert(runtime_path, 'lua/?/init.lua')
--
-- require('lspconfig').sumneko_lua.setup {
-- 	capabilities = capabilities,
-- 	cmd = { vim.env.HOME .. '/.config/nvim/plugged/lua-language-server/bin/lua-language-server' },
-- 	settings = {
-- 		Lua = {
-- 			runtime = {
-- 				version = 'LuaJIT',
-- 				path = runtime_path,
-- 			},
-- 			diagnostics = {
-- 				globals = { 'vim' },
-- 			},
-- 			workspace = {
-- 				library = vim.api.nvim_get_runtime_file('', true),
-- 			},
-- 			telemetry = {
-- 				enable = false,
-- 			},
-- 		},
-- 	},
-- }
--
--
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require 'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        -- Now, you don't get error/warning "Undefined global `vim`".
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- By default, lua-language-server sends anonymized data to its developers. Stop it using the following.
      telemetry = {
        enable = false,
      },
    },
  },
}
