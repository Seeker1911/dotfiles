local Terminal  = require('toggleterm.terminal').Terminal

local gotop = Terminal:new({ cmd = "gotop", hidden = true, size=60,
                            direction='float',
                            float_opts = {
                                    border = "double",
                                  },
                          })

function _gotop_toggle()
    gotop:toggle()
end

vim.api.nvim_set_keymap("n", "<F8>", "<cmd>lua _gotop_toggle()<CR>", {noremap = true, silent = true})







-- NOTE: Couldn't get this to work, seems like commands that return exit code don't work
-- local git_status = Terminal:new({ cmd = "git status", size=50,
--                             hidden = true,
--                             direction = 'float',
--                             close_on_exit = false,
--                           })
--
-- function _git_status()
--      git_status:toggle()
-- end
--
-- vim.api.nvim_set_keymap("n", "<F9>", "<cmd>lua _git_status()<CR>", {noremap = true, silent = true})
--
-- The hack that works, but toggle is not available, will just run the command again
vim.api.nvim_set_keymap('n', '<F9>', ':TermExec cmd="git status" direction="float"<CR>i', {noremap = true})







local ipython = Terminal:new({ cmd = "ipython", hidden = true, size=60,
                            direction='float',
                            float_opts = {
                                    border = "curved",
                                  },
                          })

function _ipython()
     ipython:toggle()
end

vim.api.nvim_set_keymap("n", "<F10>", "<cmd>lua _ipython()<CR>", {noremap = true, silent = true})
