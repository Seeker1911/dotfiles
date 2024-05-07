local actions = require("telescope.actions")
local fb_actions = require "telescope".extensions.file_browser.actions
local action_layout = require("telescope.actions.layout")
local trouble = require("trouble.providers.telescope")

require('telescope').setup{
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
        width = 0.7,
        height = 0.7
      -- horizontal = { width = 0.4 }
    },
    file_ignore_patterns = {"node_modules", "build", ".git/"},
    prompt_prefix='🔍 >',
    mappings = {
      n = {
        ["<C-p>"] = action_layout.toggle_preview
      },
      i = {
        ["<C-h>"] = "which_key",
        ["<C-T>"] = trouble.open_with_trouble
      }
    }
  },
  pickers = {
    find_files = {
      mappings = {
        n = {
          ["cd"] = function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
            require("telescope.actions").close(prompt_bufnr)
            -- Depending on what you want put `cd`, `lcd`, `tcd`
            vim.cmd(string.format("silent lcd %s", dir))
          end
        }
      }
    },
    buffers = {
            ignore_current_buffer = true,
            sort_lastused = true,
            mappings = {
            ["i"] = {
              -- your custom insert mode mappings
                 ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
            },
            ["n"] = {
              -- your custom normal mode mappings
            },
          },
        },
  },
  extensions = {
    file_browser = {
      -- file_ignore_patterns = {"node_modules", "build", ".git/"},
      file_ignore_patterns = {},
      theme = "ivy",
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        -- ["<C-/>"] = fb_actions.goto_home_dir
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
  }
 }
}
require("telescope").load_extension("file_browser")
-- require("telescope").load_extension("gh")
