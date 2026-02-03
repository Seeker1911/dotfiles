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
-- Files
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope: Files" })
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "Telescope: All files (hidden)" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope: Old files (recent)" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope: Buffers" })
map("n", "<leader>fr", "<cmd>Telescope resume<CR>", { desc = "Telescope: Resume last" })

-- Search/Grep
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope: Words (grep)" })
map("n", "<leader>fg", "<cmd>Telescope grep_string<CR>", { desc = "Telescope: Grep cursor word" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope: Fuzzy in buffer" })

-- LSP (,fl)
map("n", "<leader>fld", "<cmd>Telescope diagnostics<CR>", { desc = "Telescope: Diagnostics" })
map("n", "<leader>flr", "<cmd>Telescope lsp_references<CR>", { desc = "Telescope: References" })
map("n", "<leader>fls", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Telescope: Document symbols" })
map("n", "<leader>flS", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Telescope: Workspace symbols" })
map("n", "<leader>fli", "<cmd>Telescope lsp_implementations<CR>", { desc = "Telescope: Implementations" })
map("n", "<leader>flt", "<cmd>Telescope treesitter<CR>", { desc = "Telescope: Treesitter symbols" })

-- Vim internals (,fv)
map("n", "<leader>fvk", "<cmd>Telescope keymaps<CR>", { desc = "Telescope: Keymaps" })
map("n", "<leader>fvc", "<cmd>Telescope commands<CR>", { desc = "Telescope: Commands" })
map("n", "<leader>fvm", "<cmd>Telescope marks<CR>", { desc = "Telescope: Marks" })
map("n", "<leader>fvr", "<cmd>Telescope registers<CR>", { desc = "Telescope: Registers" })
map("n", "<leader>fvh", "<cmd>Telescope highlights<CR>", { desc = "Telescope: Highlights" })
map("n", "<leader>fvq", "<cmd>Telescope quickfix<CR>", { desc = "Telescope: Quickfix" })
map("n", "<leader>fvl", "<cmd>Telescope loclist<CR>", { desc = "Telescope: Loclist" })
map("n", "<leader>fvo", "<cmd>Telescope vim_options<CR>", { desc = "Telescope: Options" })
map("n", "<leader>fva", "<cmd>Telescope autocommands<CR>", { desc = "Telescope: Autocommands" })

-- History (,fh)
map("n", "<leader>fhh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope: Help tags" })
map("n", "<leader>fhs", "<cmd>Telescope search_history<CR>", { desc = "Telescope: Search history" })
map("n", "<leader>fhc", "<cmd>Telescope command_history<CR>", { desc = "Telescope: Command history" })

-- Extensions
map("n", "<leader>fn", "<cmd>Telescope notify<CR>", { desc = "Telescope: Notifications" })

-- Quick shortcuts (also in subgroups)
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Telescope: Keymaps (quick)" })
map("n", "<leader>f.", "<cmd>Telescope builtin<CR>", { desc = "Telescope: All pickers" })
map("n", "<leader>fc", "<cmd>Telescope colorscheme<CR>", { desc = "Telescope: Colorschemes" })
map("n", "<leader>fj", "<cmd>Telescope jumplist<CR>", { desc = "Telescope: Jumplist" })
map("n", "<leader>f'", "<cmd>Telescope marks<CR>", { desc = "Telescope: Marks (quick)" })

-- ========================================
-- Git (under <leader>g)
-- ========================================
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Telescope: Git status" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Telescope: Git commits" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Telescope: Git branches" })
map("n", "<leader>gS", "<cmd>Telescope git_stash<CR>", { desc = "Telescope: Git stash" })
map("n", "<leader>gf", "<cmd>Git<CR>", { desc = "Fugitive: Status" })
map("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "Fugitive: Push" })
map("n", "<leader>gP", "<cmd>Git pull<CR>", { desc = "Fugitive: Pull" })
map("n", "<leader>gl", "<cmd>Git log --oneline<CR>", { desc = "Fugitive: Log" })

-- Gitsigns (global keymaps for discoverability)
local gs = function()
	return require("gitsigns")
end
map("n", "<leader>ghs", function() gs().stage_hunk() end, { desc = "Gitsigns: Stage hunk" })
map("n", "<leader>ghr", function() gs().reset_hunk() end, { desc = "Gitsigns: Reset hunk" })
map("v", "<leader>ghs", function() gs().stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Gitsigns: Stage selected" })
map("v", "<leader>ghr", function() gs().reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Gitsigns: Reset selected" })
map("n", "<leader>ghS", function() gs().stage_buffer() end, { desc = "Gitsigns: Stage buffer" })
map("n", "<leader>ghu", function() gs().undo_stage_hunk() end, { desc = "Gitsigns: Undo stage" })
map("n", "<leader>ghR", function() gs().reset_buffer() end, { desc = "Gitsigns: Reset buffer" })
map("n", "<leader>ghp", function() gs().preview_hunk() end, { desc = "Gitsigns: Preview hunk" })
map("n", "<leader>ghd", function() gs().diffthis() end, { desc = "Gitsigns: Diff vs index" })
map("n", "<leader>ghD", function() gs().diffthis("~") end, { desc = "Gitsigns: Diff vs HEAD~1" })
map("n", "<leader>gB", function() gs().blame_line({ full = true }) end, { desc = "Gitsigns: Blame line" })
map("n", "<leader>gtb", function() gs().toggle_current_line_blame() end, { desc = "Gitsigns: Toggle blame" })
map("n", "<leader>gtd", function() gs().toggle_deleted() end, { desc = "Gitsigns: Toggle deleted" })
map("n", "<leader>gtl", function() gs().toggle_linehl() end, { desc = "Gitsigns: Toggle line hl" })
map("n", "<leader>gtw", function() gs().toggle_word_diff() end, { desc = "Gitsigns: Toggle word diff" })

-- ========================================
-- LSP Diagnostics (under <leader>ld)
-- ========================================
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "LSP: Line diagnostic" })
map("n", "<leader>ldl", vim.diagnostic.setloclist, { desc = "LSP: Diagnostic loclist" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP: Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "LSP: Next diagnostic" })

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
