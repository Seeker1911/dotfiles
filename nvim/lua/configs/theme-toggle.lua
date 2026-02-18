local M = {}

M.themes = {
    light = {
        colorscheme = "cyberdream",
        background = "light",
        lualine = "cyberdream_light",
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
    local ok, lualine = pcall(require, "lualine")
    if ok then
        lualine.setup({ options = { theme = theme.lualine } })
    end
end

vim.api.nvim_create_autocmd("FocusGained", {
    callback = function() apply(M.get_mode()) end,
})

function M.toggle()
    local new_mode = (vim.o.background == "dark") and "light" or "dark"
    apply(new_mode)
    update_ghostty(M.themes[new_mode].ghostty)
    save_mode(new_mode)
end

return M
