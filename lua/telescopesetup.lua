local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
require('telescope').setup{
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = {
        width = 0.7,
        height = 0.7
      -- horizontal = { width = 0.4 }
    },
    file_ignore_patterns = {"node_modules", "build", ".git/"},
    prompt_prefix='🔍 >',
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<c-T>"] = trouble.open_with_trouble
      }
    }
  },
  pickers = {
    buffers = {
            ignore_current_buffer = true,
            sort_lastused = true,
        },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
  }
 }
}
require("telescope").load_extension("file_browser")
require("telescope").load_extension("gh")
