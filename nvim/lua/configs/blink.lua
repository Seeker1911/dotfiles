return {
    snippets = { preset = "luasnip" },

    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },

    keymap = {
        preset = "none",
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-Space>"] = { "show" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-f>"] = { "scroll_documentation_up", "fallback" },
    },

    completion = {
        accept = {
            auto_brackets = { enabled = true },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = {
                border = "rounded",
            },
        },
        menu = {
            border = "rounded",
        },
    },

    signature = { enabled = true },

    cmdline = {
        enabled = true,
        completion = {
            menu = { auto_show = true },
            ghost_text = { enabled = false }
        },
    },
}
