require'lspconfig'.gopls.setup{}
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.pyright.setup{capabilities = capabilities}
require'lspconfig'.pylsp.setup(
    {enabled=true,
    plugins = {
        flake8 = {enabled = true},
        yapf = {enabled = false},
        pyls_mypy = {
            enabled = false,
            live_mode = true}
    },
    }
)
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = false,
        }
    )
-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    },
    sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    }, {
    { name = 'buffer' },
    })
})
