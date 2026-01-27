return {
    "pwntester/octo.nvim",
    -- event = "UIEnter",
    cmd = "Octo",
    enabled = true,
    opts = {
        default_to_projects_v2 = true
    },
    requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        -- OR 'ibhagwan/fzf-lua',
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("octo").setup()
    end,
}
