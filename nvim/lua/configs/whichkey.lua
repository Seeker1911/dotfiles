return {
    preset = "modern",
    notify = true,
    delay = 500, -- Time in ms before which-key popup shows
    spec = {
        -- Just define GROUP names, not individual keymaps
        { "<leader>f", group = "Find", icon = "󰍉" },
        { "<leader>g", group = "Git", icon = "" },
        { "<leader>c", group = "Code", icon = "" },
        { "<leader>r", group = "Ruff/Refactor", icon = "" },
        { "<leader>w", group = "Workspace", icon = "󰙀" },
        { "<leader>d", group = "Diagnostics", icon = "" },
        { "<leader>b", group = "Buffer", icon = "" },
        { "<leader>h", group = "Hunk", icon = "" },
        { "<leader>t", group = "Trouble", icon = "" },

        -- Navigation groups
        { "]", group = "Next", icon = "" },
        { "[", group = "Previous", icon = "" },

        -- LSP groups
        { "g", group = "Go to", icon = "" },

        -- Fold group
        { "z", group = "Fold", icon = "" },

        -- Window group
        { "<C-w>", group = "Window", icon = "" },
    },

    icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
    },
}
