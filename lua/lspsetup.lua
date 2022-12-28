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
sign({ name = 'DiagnosticSignWarn', text = " "})
sign({ name = 'DiagnosticSignHint', text = " " })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    severity_sort = true,
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

---
-- capabilities
---
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
local cmp = require('cmp')
local select_opts = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    snippet = { expand = function(args)
        require('luasnip').lsp_expand(args.body)
    end },
    sources = {
        { name = 'nvim_lsp', keyword_length = 2 },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'buffer', keyword_length = 3 },
    },
    -- {
    --     {name = 'buffer'}
    -- },
    window = {
        documentation = cmp.config.window.bordered()
    },
    formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = function(entry, item)
            item.kind = string.format("%s", kind_icons[item.kind])
            local menu_icon = {
                nvim_lsp = 'λ',
                nvim_lua = '[nvim-lua]',
                buffer = 'Ω',
                luasnip = kind_icons.Snippet,
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

require("mason").setup{PATH = "append"}
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
To_install = { "sumneko_lua", "rust_analyzer", "gopls", "pylsp", "denols"}
require("mason-lspconfig").setup({
    ensure_installed = To_install,
    automatic_installation = true,
    on_attach = lsp_defaults.on_attach,
    capabilities = lsp_defaults.capabilities,
    root_dir = function() return vim.loop.cwd() end
})

Defaults = { "rust_analyzer", "gopls", "denols", "sumneko_lua"}
for _, lsp in pairs(Defaults) do
    lspconfig[lsp].setup {
        on_attach = lsp_defaults.on_attach,
        capabilities = lsp_defaults.capabilities,
        root_dir = function() return vim.loop.cwd() end
    }
end


---
-- LSP Config
---
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig.sumneko_lua.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                globals = { 'vim' }
            },
            workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
        }
    }
}
lspconfig.pylsp.setup {
    -- https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
    enabled = true,
    on_attach = lsp_defaults.on_attach,
    capabilities = lsp_defaults.capabilities,
    settings = {
        configurationSources = { "pylint" },
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
                pylint = {
                    enabled = true,
                    maxLineLength = 100,
                    args={'--rcfile ~/.config/pylintrc'}
                },
                mypy = {
                    enabled = false,
                },
                pyflakes = {
                    enabled = false,
                    exclude = {},
                },
                pyright = { enabled = false },
                isort = { enabled = true },
            }
        }
    },
}

---
-- NULL-LS
---
local ok, null_ls = pcall(require, "null-ls")
if not ok then
  print("NULL_LS NOT FOUND")
end
local b = null_ls.builtins

local sources = {
  -- format html and markdown
  -- b.formatting.prettierd.with { filetypes = { "html", "yaml", "markdown" } },
  -- markdown diagnostic
  -- b.diagnostics.markdownlint.with { filetypes = { "markdown" }},
  -- -- python formatting
  -- b.formatting.black.with { filetypes = { "python" }},
  -- b.formatting.isort.with { filetypes = { "python" }},
  -- TODO: mypy: [import] Cannot find implementation or library stub for module named "im" (mypy)
  b.diagnostics.mypy.with { filetypes = { "python" }},
  -- b.completion.luasnip,
  -- TODO: worth investigation
  -- b.diagnostics.ruff.with { filetypes = { "python" }},
  -- b.formatting.ruff,
  --
  -- NOTE: ex. of custom command
  -- b.diagnostics.mypy.with({
  --     command = vim.fn.system({ "which", "mypy" }):gsub("[\n]", ""),
  --     print(vim.fn.system({ "which", "mypy" }):gsub("[\n]", "")),
  --
  --    }),
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
  vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        -- < 0.8 use vim.lsp.buf.formatting_sync()
        vim.lsp.buf.format({ bufnr = bufnr })
        end,
    })
  end
end
null_ls.setup {
  debug = true,
  -- log_level = "error",
  sources = sources,
  diagnostics_format ="[#{c}] #{m} (#{s})",
  notify_format = "[NULL-LS] %s",
  -- on_attach = on_attach,
  root_dir = function() return vim.loop.cwd() end,
  -- prefer_local = true,
  -- capabilities = capabilities,
  -- should_attach = function(bufnr)
  --       return not vim.api.nvim_buf_get_name(bufnr):match("^git://")
  --   end,
}

for _, source in pairs(sources) do
    print(null_ls.is_registered(source))
    local bufnr = vim.api.nvim_get_current_buf()
    local id = vim.lsp.get_client_by_id()
    if not vim.lsp.buf_is_attached(bufnr, id) then
        print(id)
        print(source.name)
        print('not attached')
        -- vim.lsp.buf_attach_client(bufnr)
    else
        print('attached')
    end
end
