local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options
require('plugins')
require('cmpsetup')
require('lspsetup')

cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

cmd 'colorscheme gruvbox'
opt.hidden = true
opt.completeopt = {'menuone', 'noinsert', 'noselect'}
opt.ignorecase = true
opt.termguicolors = true
opt.wrap = false
opt.number = true
opt.background = 'dark'

g.mapleader = ','

-- function to help remap vim commands
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('i', 'jj', '<ESC>')
map('n', '<leader>F', ':Rg<CR>')
map('n', '<leader>f', ':Files<CR>')
map('n', '<leader>b', ':Buffers<CR>')
map('n', '<leader>c', ':Commands<CR>')
map('n', '<leader>h', '<cmd>nohlsearch<CR>')

 
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', 'K', '<cmd>buf.hover()<CR>')

