local function nf(codepoint)
    return vim.fn.nr2char(codepoint)
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn", "info", "hint" },
    symbols = {
        error = nf(0xF06A) .. " ",
        warn = nf(0xF071) .. " ",
        info = nf(0xF05A) .. " ",
        hint = nf(0xF0EB) .. " ",
    },
    colored = true,
    update_in_insert = false,
    always_visible = false,
}

local diff = {
    "diff",
    source = function()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
            return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
            }
        end
    end,
    symbols = {
        added = nf(0xF055) .. " ",
        modified = nf(0xF040) .. " ",
        removed = nf(0xF056) .. " ",
    },
    colored = true,
    always_visible = false,
    padding = { left = 1, right = 3 },
}

local lsp_clients = {
    function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then return "" end
        local names = {}
        for _, client in ipairs(clients) do
            table.insert(names, client.name)
        end
        return nf(0xF085) .. " " .. table.concat(names, ", ")
    end,
}

return {
    options = {
        icons_enabled = true,
        theme = "cyberdream_light",
        component_separators = "",
        section_separators = "",
        disabled_filetypes = { "mason", "lazy", "NvimTree" },
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = {
            {
                "filename",
                path = 1,
                shorting_target = 50,
            },
            lsp_clients,
        },
        lualine_x = { diff, diagnostics, { "filetype", icon_only = true } },
        lualine_y = {},
        lualine_z = {},
    },
    extensions = { "lazy" },
}
