require('toggleterm').setup{size = 1, direction = 'float'}

local Terminal  = require('toggleterm.terminal').Terminal
-- gotop
local gotop = Terminal:new({ cmd = "gotop", hidden = true, size=60,
                            direction='float',
                            float_opts = {
                                    border = "double",
                                  },
                          })

function _gotop_toggle()
    return gotop:toggle()
end

vim.api.nvim_set_keymap("n", "<F8>", "<cmd>lua _gotop_toggle()<CR>", {noremap = true, silent = true})


-- ipython
local ipython = Terminal:new({ cmd = "ipython", hidden = true, size=60,
                            direction='float',
                            float_opts = {
                                    border = "curved",
                                  },
                          })

function _ipython()
     return ipython:toggle()
end


vim.api.nvim_set_keymap("n", "<F10>", "<cmd>lua _ipython()<CR>", {noremap = true, silent = true})





-- git status
vim.api.nvim_set_keymap('n', '<F9>', ':2TermExec cmd="git status" direction="float"<CR>', {noremap = true})
