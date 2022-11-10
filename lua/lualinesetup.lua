local lualine = require('lualine')
local space = {
    function()
        return '%='
    end,
}
local lsp_server = {
    -- Lsp server name .
    function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = '  LSP:',
    -- color = { fg = '#ffffff', gui = 'bold' },
}
local lualine_diag =
{
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    diagnostics_color = {
        color_error = { fg = 'DiagnosticError' },
        color_warn = { fg = 'DiagnosticWarn' },
        color_info = { fg = 'diagnosticInfo' },
    },
    colored = true, -- Displays diagnostics status in color if set to true.
    update_in_insert = true, -- Update diagnostics in insert mode.
    always_visible = true, -- Show diagnostics even if there are none.
}

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'gruvbox_dark',
        -- theme = 'gruvbox',
        -- theme = 'gruvbox-material',
        -- theme = 'everforest',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = { 'mode' },
        -- lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_b = { { 'FugitiveHead', icon = '' }, },
        -- lualine_c = {'filename',"require'lsp-status'.status()", 'FugitiveStatusline()' },
        lualine_c = { lualine_diag, space,  lsp_server },
        lualine_x = { 'diff', 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = { 'fugitive', 'fzf' }
}
