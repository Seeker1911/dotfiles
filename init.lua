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
require('lspsetup')
require('dapsetup')
--require('terraformsetup')
require('lualinesetup')
require('telescopesetup')
require('web_icons')
require('tmux_nav')
require('Comment').setup()
require('symbols-setup')

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
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "soft", -- can be "hard", "soft" or empty string
  palette_overrides = {
    light0_soft = "#d5c4a1",
  },
  overrides = {},
  dim_inactive = true,
  transparent_mode = false,
})
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
vim.g.laststatus = 3 -- global status line
vim.g.python3_host_prog = "~/.pyenv/versions/neovim3/bin/python3"


vim.opt.wildignore:append { "*.pyc", "node_modules" }
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.pumheight = 10 -- limit completion options

vim.opt.termguicolors = true
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
-- vim.o.foldlevel = 4

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
-- Commands mode
vim.o.wildmenu = true -- on TAB, complete options for system command
vim.o.wildignore = 'deps,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc'

-- https://github.com/neovim/neovim/issues/21749#issuecomment-1378720864
-- Fix loading of json5
table.insert(vim._so_trails, "/?.dylib")


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
map('n', '<leader>n', ':Telescope file_browser<CR>')
map('n', '<leader>q', ':Telescope quickfix<CR>')
map('n', '<leader>s', ':so ~/.background<CR>')
map('n', '<leader>o', ':SymbolsOutline<CR>')
-- map('n', '<leader>n', ':Neotree<CR>')
map('n', '<leader>z', ':ZenMode<CR>')
map('n', '<space>', 'za')
map('t', '<Esc>', '<C-\\><C-n>')


function file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then io.close(f) return true else return false end
end

if file_exists(HOME .. "/.background")
then
    vim.cmd.source('~/.background')
end


local api = vim.api
local M = {}

--TODO: Make a function with keymap to call something like the following (accepting arg for pane)
--:exe "!tmux send -t <PANE> 'pytest...' Enter"


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
    augroup file_group
    autocmd!
      au Filetype javascript setlocal ts=4 sw=4 sts=0 noexpandtab
      au Filetype typescript setlocal ts=4 sw=4 sts=0 noexpandtab
      au Filetype *.tsx setlocal ts=4 sw=4 sts=0 noexpandtab
      au FileType python                  set ts=4 sw=4
      au BufRead,BufNewFile *.md          set ft=mkd tw=80 syntax=markdown
      au BufRead,BufNewFile *.ppmd        set ft=mkd tw=80 syntax=markdown
      au BufRead,BufNewFile *.markdown    set ft=mkd tw=80 syntax=markdown
      au BufRead,BufNewFile *.slimbars    set syntax=slim
    augroup END
]])


vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

