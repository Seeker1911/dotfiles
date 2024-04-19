local lualine = require('lualine')

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local filename = {
    'filename',
    cond = conditions.buffer_not_empty,
}

local space = {
    function()
        return '%='
    end,
    cond = conditions.hide_in_width,
}

local lsp_server = {
    function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        local active_clients = {}
        local seen = {}
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                if not seen[client.name] then
                    active_clients[#active_clients + 1] = client.name
                    seen[client.name] = true
                end
            end
        end
        if #active_clients > 0 then
            return table.concat(active_clients, ' | ')
        else
            return msg
        end
    end,
    icon = '  LSPs:',
    color = { fg = '#ffffff', gui = 'bold' },
}

local lualine_diag = {
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
    cond = conditions.hide_in_width,
}

lualine.setup {
    options = {
        icons_enabled = true,
        -- theme = 'gruvbox_dark',
        -- theme = 'gruvbox',
        theme = 'gruvbox-material',
        -- theme = 'everforest',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'FugitiveHead', icon = '' }, filename },
        lualine_c = { lualine_diag, space, lsp_server },
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
