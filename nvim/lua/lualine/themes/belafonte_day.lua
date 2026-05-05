local colors = {
    bg     = "#d4ccb9",
    fg     = "#45363b",
    fg_dim = "#5e5252",
    red    = "#bd100d",
    green  = "#858062",
    yellow = "#e9a448",
    blue   = "#416978",
    rust   = "#96522b",
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
