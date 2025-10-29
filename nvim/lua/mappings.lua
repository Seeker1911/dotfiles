local map = vim.keymap.set

-- ========================================
-- Insert Mode Mappings
-- ========================================
map("i", "jj", "<ESC>", { desc = "escape insert mode" })
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- ========================================
-- Window Navigation
-- ========================================
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- ========================================
-- Window Resizing
-- ========================================
map("n", "<M-,>", "<c-w>5<", { desc = "decrease window width" })
map("n", "<M-.>", "<c-w>5>", { desc = "increase window width" })
map("n", "<M-t>", "<c-w>5+", { desc = "increase window height" })
map("n", "<M-s>", "<c-w>5-", { desc = "decrease window height" })

-- ========================================
-- General Editing
-- ========================================
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "clear search highlights" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "copy whole file" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "quit window" })
map("n", "<leader>x", "<cmd>x<CR>", { desc = "save and quit" })

-- Line numbers
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })

-- Search with cursor centered
map("n", "n", "nzzzv", { desc = "search next (centered)" })
map("n", "N", "Nzzzv", { desc = "search previous (centered)" })

-- Keep visual selection when indenting
map("v", "<", "<gv", { desc = "indent left and reselect" })
map("v", ">", ">gv", { desc = "indent right and reselect" })

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selection up" })

-- Better paste (don't yank replaced text)
map("v", "p", '"_dP', { desc = "paste without yanking" })

-- ========================================
-- Formatting
-- ========================================
map("n", "<leader>fm", function()
    require("conform").format({ lsp_fallback = true })
end, { desc = "format file" })

-- Ruff specific commands (Python)
map("n", "<leader>rf", function()
    if vim.bo.filetype == "python" then
        require("conform").format({ formatters = { "ruff_fix", "ruff_format" } })
    else
        vim.notify("Ruff is only for Python files", vim.log.levels.WARN)
    end
end, { desc = "ruff fix and format" })

map("n", "<leader>rl", function()
    if vim.bo.filetype == "python" then
        require("conform").format({ formatters = { "ruff_fix" } })
    else
        vim.notify("Ruff is only for Python files", vim.log.levels.WARN)
    end
end, { desc = "ruff lint fix only" })

-- ========================================
-- Buffer Management
-- ========================================
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "new buffer" })
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "delete buffer" })
map("n", "<leader>ba", "<cmd>bufdo bd<CR>", { desc = "delete all buffers" })

-- ========================================
-- Comments
-- ========================================
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- ========================================
-- File Explorer (NvimTree)
-- ========================================
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "toggle file tree" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "focus file tree" })

-- ========================================
-- Telescope (Fuzzy Finder)
-- ========================================
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "find files" })
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "find all files (hidden/ignored)" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "live grep search" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "search help" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "find old files" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "fuzzy find in buffer" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "find keymaps" })
map("n", "<leader>fc", "<cmd>Telescope commands<CR>", { desc = "find commands" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "find marks" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "browse git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "show git status" })

-- ========================================
-- LSP & Diagnostics
-- ========================================
map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "open diagnostic float" })
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "show diagnostic loclist" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "next diagnostic" })

-- ========================================
-- Code Folding
-- ========================================
map("n", "<SPACE>", "za", { desc = "toggle current fold" })
map("n", "zR", "zR", { desc = "open all folds" })
map("n", "zM", "zM", { desc = "close all folds" })

-- ========================================
-- Terminal
-- ========================================
map("t", "jj", "<C-\\><C-N>", { desc = "escape terminal mode" })
map({ "n", "t" }, "<Esc>i", function()
    require("configs.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "toggle floating terminal" })

-- ========================================
-- Quick-fix List Navigation
-- ========================================
map("n", "[q", "<cmd>cprev<CR>", { desc = "previous quickfix item" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "next quickfix item" })
map("n", "<leader>co", "<cmd>copen<CR>", { desc = "open quickfix list" })
map("n", "<leader>cc", "<cmd>cclose<CR>", { desc = "close quickfix list" })

-- ========================================
-- Utilities
-- ========================================
map("n", "<leader>wk", function()
    vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "whichkey query lookup" })

-- ========================================
-- Test Runners
-- ========================================
map("n", "<leader>rt", function()
    local file = vim.fn.expand("%")
    local cur_ft = vim.bo.filetype

    local runners = {
        javascript = "npm test " .. file,
        typescript = "pnpm ts " .. file,
    }

    local cmd = runners[cur_ft]
    if not cmd then
        vim.notify("no runner for " .. cur_ft, vim.log.levels.ERROR)
        return
    end

    vim.cmd("vsplit")
    vim.cmd("terminal " .. cmd)
    vim.cmd("startinsert")
end, { desc = "run typescript/javascript file" })

-- ========================================
-- Menus & Context Actions
-- ========================================
map("n", "<C-t>", function()
    require("menu").open("default")
end, { desc = "open menu" })

map({ "n", "v" }, "<RightMouse>", function()
    require("menu.utils").delete_old_menus()
    vim.cmd.exec('"normal! \\<RightMouse>"')
    local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
    local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"
    require("menu").open(options, { mouse = true })
end, { desc = "open context menu" })

-- ========================================
-- Theme & UI Toggles
-- ========================================
map("n", "<leader>tt", "<cmd>CyberdreamToggleMode<CR>", { desc = "toggle theme mode" })

-- Legacy Alacritty theme toggle (now using Ghostty)
map("n", "<leader>tcd", function()
    local dark_theme = "~/.config/alacritty/themes/themes/cyberdream.toml"
    local light_theme = "~/.config/alacritty/themes/themes/cyberdream-light.toml"
    local current_background = vim.o.background
    local command

    if current_background == "dark" then
        command = string.format("echo \"general.import = ['%s']\" > ~/.alacritty_background.toml", light_theme)
        vim.o.background = "light"
    else
        command = string.format("echo \"general.import = ['%s']\" > ~/.alacritty_background.toml", dark_theme)
        vim.o.background = "dark"
    end

    os.execute(command)
    vim.cmd("CyberdreamToggleMode")
    print("Switched background to " .. vim.o.background .. " mode")
end, { desc = "toggle cyberdream + alacritty theme" })

-- ========================================
-- Development Helpers
-- ========================================
map("n", "<leader>l", function()
    vim.api.nvim_feedkeys("i const log = (x: any) => { console.log(`🚨 🚨: `, x); return x }", "n", false)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end, { desc = "insert console.log helper" })
