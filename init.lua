local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options
HOME = os.getenv("HOME")
require('plugins')
-- require('lspv2')
require('lspsetup')
require('terraformsetup')
require('treesitter')
require('lualinesetup')
require('telescopesetup')
require('web_icons')
require('tmux_nav')
require('Comment').setup()
require('symbols-setup')

-- disable netrw in favor of nvim-tree & telescope file_browser
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

cmd('syntax enable')
cmd([[colorscheme gruvbox]]) -- may be overidden at end of file
g.gruvbox_contrast_dark = 'soft'

opt.termguicolors = true
opt.hidden = true
-- opt.autoread = true
opt.history = 1000
opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
opt.ignorecase = true
opt.wrap = false
opt.number = true
opt.background = 'dark'
opt.clipboard = 'unnamed'
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.termguicolors = true
opt.shell = 'bash -l'
opt.foldmethod='expr'
opt.foldexpr='nvim_treesitter#foldexpr()'
-- opt.nofoldenable = true
opt.foldnestmax = 3
opt.foldminlines = 4

vim.o.scrolloff = 3
vim.o.wrap = false
vim.o.showbreak = '↪' -- character to show when line is broken
vim.o.signcolumn = 'yes' -- keep 1 column for coc.vim  check
vim.o.modelines = 0
vim.o.smartcase = true -- case insentive unless capitals used in search

-- Backup files
vim.o.backup = true -- use backup files
vim.o.writebackup = false
vim.o.swapfile = false -- do not use swap file
vim.o.undodir = HOME .. '/.vim/tmp/undo//' -- undo files
vim.o.backupdir = HOME .. '/.vim/tmp/backup//' -- backups
vim.o.directory = '/.vim/tmp/swap//' -- swap files

cmd([[
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

g.mapleader = ','
g.laststatus = 3 -- global status line
-- g.python3_host_prog = "~/.pyenv/versions/neovim3/bin/python3"
-- g.python3_host_prog = "/Users/michaelmead/.pyenv/versions/3.9.6/bin/python"

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
map('n', '<leader>t', ':Telescope help_tags<CR>')
map('n', '<leader>c', ':Telescope commands<CR>')
map('n', '<leader>k', ':Telescope keymaps<CR>')
map('n', '<leader>fb', ':Telescope file_browser<CR>')
map('n', '<leader>s', ':so ~/.background<CR>')
map('n', '<leader>o', ':SymbolsOutline<CR>')
map('n', '<leader>n', ':NvimTreeToggle<CR>')
map('t', '<Esc>', '<C-\\><C-n>')


function file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then io.close(f) return true else return false end
end

if file_exists(HOME .. "/.background")
then
    cmd('source ~/.background')
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
