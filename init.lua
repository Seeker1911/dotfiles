local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options
HOME = os.getenv("HOME")
require('plugins')
require('cmpsetup')
require('lspsetup')
-- require('luasetup')
require('treesitter')
require('lualinesetup')
require('telescopesetup')
-- require('tmux_nav')
require('web_icons')
require('Comment').setup()

cmd([[colorscheme gruvbox]]) -- may be overidden at end of file
g.gruvbox_contrast_dark = 'soft'

opt.hidden = true
opt.completeopt = {'menuone', 'noinsert', 'noselect'}
opt.ignorecase = true
opt.termguicolors = true
opt.wrap = false
opt.number = true
opt.background = 'dark'
opt.clipboard = 'unnamed'
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.termguicolors = true
opt.shell = 'bash -l'

vim.o.scrolloff = 3
vim.o.wrap = false
vim.o.showbreak= '↪' -- character to show when line is broken
vim.o.signcolumn = 'yes' -- keep 1 column for coc.vim  check
vim.o.modelines = 0
vim.o.smartcase = true -- case insentive unless capitals used in search

-- Backup files
vim.o.backup = true -- use backup files
vim.o.writebackup = false
vim.o.swapfile = false -- do not use swap file
vim.o.undodir = HOME .. '/.vim/tmp/undo//'     -- undo files
vim.o.backupdir = HOME .. '/.vim/tmp/backup//' -- backups
vim.o.directory = '/.vim/tmp/swap//'   -- swap files

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
g.python3_host_prog = "~/.pyenv/versions/neovim3/bin/python"
g.python_host_prog = "~/.pyenv/versions/neovim2/bin/python"

-- function to help remap vim commands
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('i', 'jj', '<ESC>')
map('i', 'JJ', '<ESC>')
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', '<leader>h', '<cmd>nohlsearch<CR>')
map('n', '<leader>f', ':Telescope find_files hidden=true<CR>')
map('n', '<leader>F', ':Telescope live_grep<CR>')
map('n', '<leader>b', ':Telescope buffers<CR>')
map('n', '<leader>t', ':Telescope help_tags<CR>')
map('n', '<leader>c', ':Telescope commands<CR>')
map('n', '<leader>k', ':Telescope keymaps<CR>')
map('n', '<leader>fb',':Telescope file_browser<CR>')
map('n', '<leader>s', ':so ~/.background<CR>')
map('n', '<leader>o', ':SymbolsOutline<CR>')


function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

if file_exists(HOME .. "/.background")
    then
        cmd('source ~/.background')
end
