require('cmpsetup')
-- require('nls')

vim.api.nvim_create_autocmd('User', {
    pattern = 'LspAttached',
    desc = 'LSP actions',
    callback = function()
        local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = true }
            vim.keymap.set(mode, lhs, rhs, opts)
        end
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
        bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
        bufmap('n', 'gD', '<cmd>TroubleToggle document_diagnostics<cr>')
        bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
        bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
        bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
        bufmap('n', 'gR', '<cmd>Trouble lsp_references<cr>')
        bufmap('n', 'gk', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
        bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
        bufmap('n', 'gL', '<cmd>TroubleToggle workspace_diagnostics<cr>')
        bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
        bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
        bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
        bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
        bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
        bufmap('n', '<F5>', '<cmd>lua vim.lsp.buf.format()<cr>')
        bufmap('n', '<F6>', '<cmd>lua vim.diagnostic.hide()<cr>')
        bufmap('n', '<F7>', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
              end, bufopts)


    end
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
sign({ name = 'DiagnosticSignError', text = '✘' })
-- sign({ name = 'DiagnosticSignError', text = 'ﮊ' })
sign({ name = 'DiagnosticSignWarn', text = " "})
sign({ name = 'DiagnosticSignHint', text = " " })
sign({ name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    severity_sort = false,
    update_in_insert = true,
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


local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_defaults = {
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities,
    vim.lsp.protocol.make_client_capabilities(),
    on_attach = function(client, bufnr)
        vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
    end
}

require("mason").setup{
    PATH = "append",
    pip = {upgrade_pip = true}
}
local lspconfig = require('lspconfig')

lspconfig.util.default_config = vim.tbl_deep_extend(
    'force',
    lspconfig.util.default_config,
    lsp_defaults
)
lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    capabilities
)

---
-- Mason Config
---
local mason_lspconfig = require("mason-lspconfig")
ToInstall = { "rust_analyzer", "gopls", "denols", "terraformls", "lua_ls", "ruff_lsp", "pylsp"}
mason_lspconfig.setup({
    ensure_installed = ToInstall,
    automatic_installation = true,
    on_attach = lsp_defaults.on_attach,
    capabilities = lsp_defaults.capabilities,
})

AcceptDefaults = { "rust_analyzer", "gopls", "denols", "terraformls", "lua_ls", "jedi_language_server"}
for _, lsp in pairs(AcceptDefaults) do
    lspconfig[lsp].setup {
        on_attach = lsp_defaults.on_attach,
        capabilities = lsp_defaults.capabilities,
    }
end

lspconfig.ruff_lsp.setup {
    on_attach = lsp_defaults.on_attach,
    capabilities = lsp_defaults.capabilities,
    init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      -- args = {"--config=/path/to/pyproject.toml"},
      args = {},
    }
  }
}

lspconfig.pylsp.setup {
    -- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
    enabled = false,
    on_attach = lsp_defaults.on_attach,
    capabilities = lsp_defaults.capabilities,
    root_dir = function() return vim.loop.cwd() end,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = false,
                    ignore = {},
                    maxLineLength = 100
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
                    enabled = true,
                    maxLineLength = 100,
                    args={'--rcfile ~/.config/pylintrc'}
                },
            }
        }
    },
}
