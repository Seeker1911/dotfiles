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

-- Line numbers
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })

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
end, { desc = "Conform: format file" })

-- Ruff specific commands (Python)
map("n", "<leader>rf", function()
    if vim.bo.filetype == "python" then
        require("conform").format({ formatters = { "ruff_fix", "ruff_format" } })
    else
        vim.notify("Ruff is only for Python files", vim.log.levels.WARN)
    end
end, { desc = "Ruff: fix and format" })

map("n", "<leader>rl", function()
    if vim.bo.filetype == "python" then
        require("conform").format({ formatters = { "ruff_fix" } })
    else
        vim.notify("Ruff is only for Python files", vim.log.levels.WARN)
    end
end, { desc = "Ruff: lint fix only" })

-- ========================================
-- Comments
-- ========================================
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- ========================================
-- File Explorer (NvimTree)
-- ========================================
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "NvimTree: toggle file tree" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "NvimTree: focus file tree" })

-- ========================================
-- Telescope (Fuzzy Finder)
-- ========================================
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope: find files" })
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
    { desc = "Telescope: find all files (hidden/ignored)" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope: live grep search" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope: find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope: search help" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope: find old files" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope: fuzzy find in buffer" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Telescope: find keymaps" })
map("n", "<leader>fc", "<cmd>Telescope commands<CR>", { desc = "Telescope: find commands" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "Telescope: find marks" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Git: browse commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Git: show status" })

-- ========================================
-- LSP & Diagnostics
-- ========================================
map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "LSP: open diagnostic float" })
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP: show diagnostic loclist" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP: previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "LSP: next diagnostic" })

-- ========================================
-- Code Folding
-- ========================================
map("n", "<SPACE>", "za", { desc = "toggle current fold" })

-- ========================================
-- Terminal
-- ========================================
map("t", "jk", "<C-\\><C-N>", { desc = "Terminal: escape terminal mode" })
map({ "n", "t" }, "<Esc>i", function()
    require("configs.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "Terminal: toggle floating terminal" })

-- ========================================
-- Quick-fix List Navigation
-- ========================================
map("n", "[q", "<cmd>cprev<CR>", { desc = "previous quickfix item" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "next quickfix item" })

-- ========================================
-- Utilities
-- ========================================
map("n", "<leader>wk", function()
    vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "WhichKey: query lookup" })

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
-- Theme & UI Toggles
-- ========================================
map("n", "<leader>tt", "<cmd>CyberdreamToggleMode<CR>", { desc = "Cyberdream: toggle theme mode" })

-- ========================================
-- Development Helpers
-- ========================================
map("n", "<leader>log", function()
    vim.api.nvim_feedkeys("i const log = (x: any) => { console.log(`🚨 🚨: `, x); return x }", "n", false)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end, { desc = "insert console.log helper" })
