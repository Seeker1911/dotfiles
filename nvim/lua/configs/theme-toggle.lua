local M = {}

M.themes = {
    light = {
        colorscheme = "cyberdream",
        background = "light",
        lualine = "evil_lualine",
        ghostty = "cyberdream-light",
    },
    dark = {
        colorscheme = "gruvbox",
        background = "dark",
        lualine = "gruvbox_custom",
        ghostty = "Gruvbox Dark",
    },
}

local state_file = vim.fn.stdpath("data") .. "/.theme_mode"

local function octo_left_ns()
    return vim.api.nvim_create_namespace("octo_review_left_highlight")
end

local function octo_right_ns()
    return vim.api.nvim_create_namespace("octo_review_right_highlight")
end

local function apply_octo_diff_highlights()
    if vim.o.background ~= "light" then return end
    local set = vim.api.nvim_set_hl
    set(octo_left_ns(), "DiffText", { background = "#ef9a9a" })
    set(octo_left_ns(), "DiffChange", { link = "DiffDelete" })
    set(octo_right_ns(), "DiffText", { background = "#a5d6a7" })
    set(octo_right_ns(), "DiffChange", { link = "DiffAdd" })
end

local function apply_global_diff_highlights()
    if vim.o.background ~= "light" then return end
    local set = vim.api.nvim_set_hl
    set(0, "DiffAdd", { background = "#c8e6c9" })
    set(0, "DiffDelete", { background = "#ffcdd2" })
    set(0, "DiffChange", { background = "#fff9c4" })
    set(0, "DiffText", { background = "#ffe082" })
end

function M.get_mode()
    local f = io.open(state_file, "r")
    if not f then return "light" end
    local mode = f:read("*l")
    f:close()
    return (mode == "dark") and "dark" or "light"
end

local function save_mode(mode)
    local f = io.open(state_file, "w")
    if not f then return end
    f:write(mode)
    f:close()
end

local function update_ghostty(theme_name)
    local config_path = vim.fn.expand("~/.config/ghostty/config")
    local f = io.open(config_path, "r")
    if not f then return end
    local lines = {}
    for line in f:lines() do
        lines[#lines + 1] = line:match("^theme = ") and ("theme = " .. theme_name) or line
    end
    f:close()

    f = io.open(config_path, "w")
    if not f then return end
    f:write(table.concat(lines, "\n") .. "\n")
    f:close()

    vim.fn.system([[osascript -e 'tell application "System Events" to keystroke "," using {shift down, command down}']])
end

local function apply(mode)
    local theme = M.themes[mode]
    if vim.o.background == theme.background then return end
    vim.o.background = theme.background
    vim.cmd.colorscheme(theme.colorscheme)
    apply_global_diff_highlights()
    apply_octo_diff_highlights()
    local ok, lualine = pcall(require, "lualine")
    if ok then
        lualine.setup({ options = { theme = theme.lualine } })
    end
end

vim.api.nvim_create_autocmd("FocusGained", {
    callback = function() apply(M.get_mode()) end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "LazyLoad",
    callback = function(args)
        if args.data ~= "octo.nvim" then return end
        local ok, layout_module = pcall(require, "octo.reviews.layout")
        if not ok or not layout_module.Layout then return end
        local original = layout_module.Layout.init_layout
        layout_module.Layout.init_layout = function(self)
            original(self)
            apply_octo_diff_highlights()
        end
    end,
})

function M.toggle()
    local new_mode = (vim.o.background == "dark") and "light" or "dark"
    apply(new_mode)
    update_ghostty(M.themes[new_mode].ghostty)
    save_mode(new_mode)
end

return M
