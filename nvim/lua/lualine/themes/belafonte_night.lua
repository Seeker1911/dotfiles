local colors = {
    bg     = "#20111a",
    fg     = "#d4ccb9",
    fg_dim = "#958b83",
    red    = "#d6403d",
    green  = "#a8a47e",
    yellow = "#e9a448",
    blue   = "#7aa3b3",
    rust   = "#c47550",
    gray   = "#98999c",
}

return {
    normal = {
        a = { bg = "None", fg = colors.rust,   gui = "bold" },
        b = { bg = "None", fg = colors.fg },
        c = { bg = "None", fg = colors.fg },
    },
    insert = {
        a = { bg = "None", fg = colors.green,  gui = "bold" },
        b = { bg = "None", fg = colors.fg },
        c = { bg = "None", fg = colors.fg },
    },
    visual = {
        a = { bg = "None", fg = colors.blue,   gui = "bold" },
        b = { bg = "None", fg = colors.fg },
        c = { bg = "None", fg = colors.fg },
    },
    replace = {
        a = { bg = "None", fg = colors.red,    gui = "bold" },
        b = { bg = "None", fg = colors.fg },
        c = { bg = "None", fg = colors.fg },
    },
    command = {
        a = { bg = "None", fg = colors.yellow, gui = "bold" },
        b = { bg = "None", fg = colors.fg },
        c = { bg = "None", fg = colors.fg },
    },
    terminal = {
        a = { bg = "None", fg = colors.gray,   gui = "bold" },
        b = { bg = "None", fg = colors.fg },
        c = { bg = "None", fg = colors.fg },
    },
    inactive = {
        a = { bg = "None", fg = colors.fg_dim, gui = "bold" },
        b = { bg = "None", fg = colors.fg_dim },
        c = { bg = "None", fg = colors.fg_dim },
    },
}
