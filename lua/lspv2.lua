--- Keybindings
---
vim.api.nvim_create_autocmd('User', {
    pattern = 'LspAttached',
    desc = 'LSP actions',
    callback = function()
        local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = true }
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
        bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
        bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
        bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
        bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
        bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
        bufmap('n', 'gR', ':Telescope lsp_references<cr>')
        bufmap('n', 'gk', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
        bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
        bufmap('n', 'gL', '<cmd>lua vim.diagnostic.setqflist()<cr>')
        bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
        bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
        bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
        bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
        bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
        bufmap('n', '<F5>', '<cmd>lua vim.lsp.buf.format()<cr>')
        bufmap('n', '<F6>', '<cmd>lua vim.diagnostic.hide()<cr>')


    end
})

---
-- Diagnostics
---

local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({ name = 'DiagnosticSignError', text = '✘' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚑' })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {
        border = 'rounded',
        close_events = { "CursorMoved", "BufHidden", "InsertCharPre" }
    }
)

local lsp_defaults = {
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    --vim.lsp.protocol.make_client_capabilities()
    on_attach = function(client, bufnr)
        vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
    end
}

local lspconfig = require('lspconfig')

lspconfig.util.default_config = vim.tbl_deep_extend(
    'force',
    lspconfig.util.default_config,
    lsp_defaults
)

---
-- Autocomplete
---

local cmp = require('cmp')
cmp.setup {
    sources = {
        { name = 'nvim_lsp' }
    }
}


local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    snippet = { expand = function(args)
        require('luasnip').lsp_expand(args.body)
    end },
    sources = {
        { name = 'nvim_lsp', keyword_length = 2 },
        { name = 'buffer', keyword_length = 3 },
        { name = 'nvim_lsp_signature_help' },
    },
    window = {
        documentation = cmp.config.window.bordered()
    },
    formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = 'λ',
                buffer = 'Ω',
            }

            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
    mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),


        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
})

---
-- Language servers
---
require("mason").setup()
-- local to_install = { "sumneko_lua", "rust_analyzer", "gopls", "pylsp" }
local to_install = { "rust_analyzer", "gopls", "pylsp" }
local defaults = { "rust_analyzer", "gopls", "denols" }
require("mason-lspconfig").setup({
    ensure_installed = to_install,
    automatic_installation = false
})

-- local servers = { 'tsserver', 'gopls', 'pylsp'}
for _, lsp in pairs(defaults) do
    lspconfig[lsp].setup {
        on_attach = lsp_defaults.on_attach,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        },
        capabilities = lsp_defaults.capabilities
    }
end

-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")
-- lspconfig.sumneko_lua.setup {
--     on_attach = lsp_defaults.on_attach,
--     capabilities = lsp_defaults.capabilities,
--     settings = {
--         Lua = {
--             runtime = {
--                 -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--                 version = 'LuaJIT',
--                 -- Setup your lua path
--                 path = runtime_path,
--             },
--             diagnostics = {
--                 -- Get the language server to recognize the `vim` global
--                 -- Now, you don't get error/warning "Undefined global `vim`".
--                 globals = { 'vim' },
--             },
--             workspace = {
--                 -- Make the server aware of Neovim runtime files
--                 library = vim.api.nvim_get_runtime_file("", true),
--                 checkThirdParty = false,
--             },
--             -- By default, lua-language-server sends anonymized data to its developers. Stop it using the following.
--             telemetry = {
--                 enable = false,
--             },
--         },
--     },
-- }


lspconfig.pylsp.setup {
    on_attach = lsp_defaults.on_attach,
    capabilities = lsp_defaults.capabilities,
    settings = {
        configurationSources = { "flake8" },
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = false,
                    ignore = {},
                    maxLineLength = 100
                },
                flake8 = {
                    enabled = true,
                    exclude = {},
                    indentSize = 4,
                    maxLineLength = 100
                },
                pylint = {
                    enabled = true,
                    exclude = {},
                },
                pyflakes = {
                    enabled = false,
                    exclude = {},
                },
                mypy = { enabled = false },
                isort = { enabled = true },
                black = {
                    enabled = true,
                    preview = true
                },
            }
        }
    },
}
