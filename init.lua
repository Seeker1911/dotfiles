HOME = os.getenv("HOME")
require('treesitter')
require('plugins')
require('cmpsetup')
require('lspsetup')
require('nls')
-- require('lspzero')
require('terraformsetup')
require('lualinesetup')
require('telescopesetup')
require('web_icons')
require('tmux_nav')
require('Comment').setup()
require('symbols-setup')

vim.cmd('syntax enable')
vim.cmd('colorscheme gruvbox') -- may be overidden at end of file


vim.g.loaded_netrw = 1 -- disable netrw in favor of nvim-tree & telescope file_browser
vim.g.loaded_netrwPlugin = 1
vim.g.gruvbox_contrast_dark = 'soft'
vim.g.mapleader = ','
vim.g.laststatus = 3 -- global status line
vim.g.python3_host_prog = "~/.pyenv/versions/neovim3/bin/python3"
-- vim.g.python3_host_prog = "/Users/michaelmead/.pyenv/versions/3.9.6/bin/python"

vim.opt.wildignore:append { "*.pyc", "node_modules" }
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }

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
vim.o.foldmethod='indent'
-- vim.o.foldexpr='nvim_treesitter#foldexpr()'
vim.o.foldnestmax = 4
vim.o.foldminlines = 4

vim.o.breakindent = true
vim.o.scrolloff = 3
vim.o.wrap = false
vim.o.showbreak = '↪' -- character to show when line is broken
vim.o.signcolumn = 'yes'
vim.o.modelines = 0
vim.o.smartcase = true -- case insentive unless capitals used in search

-- Backup files
vim.o.backup = true -- use backup files
vim.o.writebackup = false
vim.o.swapfile = false -- do not use swap file
vim.o.undodir = HOME .. '/.vim/tmp/undo//' -- undo files
vim.o.backupdir = HOME .. '/.vim/tmp/backup//' -- backups
vim.o.directory = '/.vim/tmp/swap//' -- swap files

vim.cmd([[
  au Filetype javascript setlocal ts=4 sw=4 sts=0 noexpandtab
  au Filetype typescript setlocal ts=4 sw=4 sts=0 noexpandtab
  au Filetype *.tsx setlocal ts=4 sw=4 sts=0 noexpandtab
  au FileType python                  set ts=4 sw=4
  au BufRead,BufNewFile *.md          set ft=mkd tw=80 syntax=markdown
  au BufRead,BufNewFile *.ppmd        set ft=mkd tw=80 syntax=markdown
  au BufRead,BufNewFile *.markdown    set ft=mkd tw=80 syntax=markdown
  au BufRead,BufNewFile *.slimbars    set syntax=slim
]])

-- Commands mode
vim.o.wildmenu = true -- on TAB, complete options for system command
vim.o.wildignore = 'deps,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc'


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
map('n', '<leader>fb', ':Telescope file_browser<CR>')
map('n', '<leader>q', ':Telescope quickfix<CR>')
map('n', '<leader>s', ':so ~/.background<CR>')
map('n', '<leader>o', ':SymbolsOutline<CR>')
map('n', '<leader>n', ':NvimTreeToggle<CR>')
map('n', '<leader>z', ':ZenMode<CR>')
map('t', '<Esc>', '<C-\\><C-n>')


function file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then io.close(f) return true else return false end
end

if file_exists(HOME .. "/.background")
then
    vim.cmd('source ~/.background')
end


local vim = vim
local api = vim.api
local M = {}
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command('augroup '..group_name)
        api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            api.nvim_command(command)
        end
        api.nvim_command('augroup END')
    end
end


local autoCommands = {
    -- other autocommands
    open_folds = {
        {"BufReadPost,FileReadPost", "*", "normal zR"}
    }
}

-- M.nvim_create_augroups(autoCommands)
