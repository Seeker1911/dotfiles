-- luacheck: globals vim
local executable = function(e)
    return vim.fn.executable(e) > 0
end
local function add(value, str, sep)
    sep = sep or ','
    str = str or ''
    value = type(value) == 'table' and table.concat(value, sep) or value
    return str ~= '' and table.concat({ value, str }, sep) or value
end

HOME = os.getenv("HOME")
require('treesitter')
require('plugins')
require('cmpsetup')
-- require('cmpsetup2')
require('lspsetup')
--require('dapsetup2')
--require('terraformsetup')
require('lualinesetup')
require('cyber-lualine')
require('telescopesetup')
require('web_icons')
require('tmux_nav')
require('Comment').setup()
require('symbols-setup')
require('gitsigns').setup()
require('cyber-setup')
require("gruvbox").setup({
    undercurl = true,
    underline = true,
    bold = false,
    italic = {
        strings = true,
        operators = true,
        comments = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true,    -- invert background for search, diffs, statuslines and errors
    contrast = "soft", -- can be "hard", "soft" or empty string
    palette_overrides = {
        light0_soft = "#d5c4a1",
    },
    overrides = {},
    dim_inactive = true,
    transparent_mode = false,
})

vim.notify = require("notify")
require('notifysetup')
require('alphasetup')

vim.g.svelte_preprocessors = { 'ts' }
vim.bo.syntax = 'ON'
vim.cmd.colorscheme('gruvbox')
vim.g.gruvbox_contrast_dark = 'soft'
vim.g.everforest_background = 'soft'
vim.g.everforest_better_performance = 1



-- Use faster grep alternatives if possible
if executable('rg') then
    vim.o.grepprg =
    [[rg --hidden --glob "!.git" --no-heading --smart-case --vimgrep --follow $*]]
    vim.o.grepformat = add('%f:%l:%c:%m', vim.o.grepformat)
elseif executable('ag') then
    vim.o.grepprg = [[ag --nogroup --nocolor --vimgrep]]
    vim.o.grepformat = add('%f:%l:%c:%m', vim.o.grepformat)
end
vim.g['jedi#auto_initialization'] = 0


vim.g.loaded_netrw = 1 -- disable netrw in favor of nvim-tree & telescope file_browser
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ','
--vim.g.laststatus = 3 -- global status line, constrolled by lualine plugin
vim.g.python3_host_prog = "~/.pyenv/versions/neovim3/bin/python3"


vim.opt.wildignore:append { "*.pyc", "node_modules" }
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.o.pumheight = 10 -- limit completion options
vim.o.timeoutlen = 500
vim.o.termguicolors = true
vim.o.hidden = true
-- vim.o.autoread = true
vim.o.history = 1000
vim.o.ignorecase = true
vim.o.wrap = false
vim.o.updatetime = 250
vim.o.number = true
vim.o.background = 'dark'
vim.o.clipboard = 'unnamed'
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.termguicolors = true
vim.o.shell = 'bash -l'
vim.o.foldmethod = 'indent'
-- vim.o.foldexpr='nvim_treesitter#foldexpr()'
vim.o.foldnestmax = 20
vim.o.foldminlines = 1
--vim.o.foldtext = ""
-- vim.o.foldlevel = 4
-- vim.o.nofoldenable = true
-- vim.o.foldlevelstart = 99

vim.o.breakindent = true
vim.o.scrolloff = 3
vim.o.wrap = false
vim.o.showbreak = '↪' -- character to show when line is broken
vim.o.signcolumn = 'yes'
vim.o.modelines = 0
vim.o.smartcase = true -- case insentive unless capitals used in search

-- Backup files
vim.o.backup = true                            -- use backup files
vim.o.writebackup = false
vim.o.swapfile = false                         -- do not use swap file
vim.o.undodir = HOME .. '/.vim/tmp/undo//'     -- undo files
vim.o.backupdir = HOME .. '/.vim/tmp/backup//' -- backups
vim.o.directory = '/.vim/tmp/swap//'           -- swap files
-- Commands mode
vim.o.wildmenu = true                          -- on TAB, complete options for system command
vim.o.wildignore =
'deps,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc'
vim.o.cursorline = true


-- function to help remap vim commands
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('i', 'jj', '<ESC>')
map('i', 'JJ', '<ESC>')
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', { expr = true })
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })

map('n', '<leader>h', '<cmd>nohlsearch<CR>')
map('n', '<leader>f', ':Telescope find_files hidden=true<CR>')
map('n', '<leader>F', ':Telescope live_grep<CR>')
map('n', '<leader>b', ':Telescope buffers<CR>')
map('n', '<leader>H', ':Telescope help_tags<CR>')
map('n', '<leader>c', ':Telescope commands<CR>')
map('n', '<leader>k', ':Telescope keymaps<CR>')
map('n', '<leader>N', ':Telescope file_browser<CR>')
map('n', '<leader>n', ':NvimTreeFindFile<CR>')
map('n', '<leader>q', ':Telescope quickfix<CR>')
map('n', '<leader>s', ':so ~/.background<CR>')
map('n', '<leader>o', ':SymbolsOutline<CR>')
map('n', '<leader>z', ':ZenMode<CR>')
map('n', '<space>', 'za')
map('t', '<Esc>', '<C-\\><C-n>')

-- Add a custom keybinding to toggle the colorscheme
vim.api.nvim_set_keymap("n", "<leader>tt", ":CyberdreamToggleMode<CR>", { noremap = true, silent = true })

function file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

if file_exists(HOME .. "/.background")
then
    vim.cmd.source('~/.background')
end


local api = vim.api
local M = {}
--
--TODO: Make a function with keymap to call something like the following (accepting arg for pane)
--:exe "!tmux send -t <PANE> 'pytest...' Enter"


-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command('augroup ' .. group_name)
        api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
            api.nvim_command(command)
        end
        api.nvim_command('augroup END')
    end
end

local autoCommands = {
    -- other autocommands
    open_folds = {
        { "BufReadPost,FileReadPost", "*", "normal zR" }
    },
    php_keyword = {
        { "FileType", "php", "set iskeyword+=$" }
    }
}

M.nvim_create_augroups(autoCommands)

-- local function FoldText()
--     local lines = {}
--     for i = vim.fn.foldstart("."),vim.fn.foldend(".") do
--         lines[#lines+1] = vim.fn.getline(i)
--     end
--     if #lines > 3 then
--         return table.concat(lines, '\n', 1, 3)
--     else
--         return table.concat(lines, '\n')
--     end
-- end
--
-- vim.api.nvim_command("set foldtext=FoldText()")

-- local function FoldText()
--     local cursor = vim.api.nvim_win_get_cursor(0)
--     local lines = vim.api.nvim_buf_get_lines(0, cursor[1]-2, cursor[1], true)
--     return table.concat(lines, '\n')
-- end
--
-- vim.api.nvim_command("set foldtext=FoldText()")

vim.cmd([[
    " augroup ProjectSetup
    "     au BufRead,BufEnter /Users/michaelmead/code/trex/* set noet tabstop=4 syntax=javascript autoindent
    "     " au BufRead,BufEnter /path/to/project2/* set noet sts=4 cindent cinoptions=...
    " augroup END

    augroup file_group
    autocmd!
" Set tabs for Svelte files
      au BufRead,BufNewFile *.svelte      set ft=svelte  ts=4  sw=4 sts=0
      au BufRead,BufNewFile *.ts          set ft=typescript  syntax=typescript ts=4 sts=4 sw=4 tw=120
      au BufRead,BufNewFile *.js          set ft=javascript  syntax=javascript ts=4 sts=4 sw=4 tw=120
      au BufRead,BufNewFile *.md          set ft=mkd tw=80 syntax=markdown
      au BufRead,BufNewFile *.ppmd        set ft=mkd tw=80 syntax=markdown
      au BufRead,BufNewFile *.markdown    set ft=mkd tw=80 syntax=markdown
      au BufRead,BufNewFile *.slimbars    set syntax=slim

      au FileType python                  set sw=4 ts=4
      au FileType svelte                  setlocal tabstop=4 shiftwidth=4 expandtab
      au FileType javascript              set noet smarttab autoindent
      au FileType typescript              set noet smarttab autoindent
      " au Filetype javascript setlocal ts=4 sw=4 sts=0 noexpandtab
      " au Filetype typescript setlocal ts=4 sw=4 sts=0 noexpandtab
      " au Filetype *.tsx setlocal ts=4 sw=4 sts=0 noexpandtab
    augroup END
]])


vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- The event data property will contain a string with either "default" or "light" respectively
vim.api.nvim_create_autocmd("User", {
    pattern = "CyberdreamToggleMode",
    callback = function(event)
        -- Your custom code here!
        -- For example, notify the user that the colorscheme has been toggled
        vim.notify("Switched to " .. event.data .. " mode!")
    end,
})

function InsertConsoleLog()
  vim.api.nvim_feedkeys("i const log = (x: any) => { console.log(`🚨 🚨: `, x); return x }", 'n', false)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'n', false)
end
-- Map a key to the function (e.g., <Leader>l for leader key + l)
vim.api.nvim_set_keymap('n', '<Leader>l', ':lua InsertConsoleLog()<CR>', { noremap = true, silent = true })

-- Define a mapping for Tab in insert mode
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab()', { expr = true, noremap = true })

-- Define a Lua function for the smart Tab behavior
function _G.smart_tab()
  local col = vim.fn.col('.')
  local line = vim.fn.getline('.')
  if col > 1 and line:sub(col - 1, col - 1) == '`' then
    return vim.api.nvim_replace_termcodes("<Right><Right><Right><Esc>F,a", true, true, true)
  else
    return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
  end
end


-- # generated with chatgpt cuz IDK how to vim
-- command! -nargs=* RunTS execute '!pnpm run ts ' . shellescape(@%, 1) . ' ' . <q-args>
-- command! -nargs=* RunTask execute '!pnpm run task_worker ' . shellescape(@%, 1) . ' ' . <q-args>



--
-- smooth scrolling
vim.cmd([[set t_TI=^[[4?h]])
vim.cmd([[set t_TE=^[[2?l]])
