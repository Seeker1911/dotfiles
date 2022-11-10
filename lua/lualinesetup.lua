local lualine_diag = {
    {
      'diagnostics',

      -- Table of diagnostic sources, available sources are:
      --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
      -- or a function that returns a table as such:
      --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
      sources = { 'nvim_diagnostic', 'nvim_lsp' },

      -- Displays diagnostics for the defined severity types
      sections = { 'error', 'warn', 'info', 'hint' },

      diagnostics_color = {
        -- Same values as the general color option can be used here.
        error = 'DiagnosticError', -- Changes diagnostics' error color.
        warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
        info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
        hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
      },
      symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
      colored = true,           -- Displays diagnostics status in color if set to true.
      update_in_insert = true, -- Update diagnostics in insert mode.
      always_visible = true,   -- Show diagnostics even if there are none.
    }
  }
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox_dark',
    -- theme = 'gruvbox',
    -- theme = 'gruvbox-material',
    -- theme = 'everforest',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    -- lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_b = { {'FugitiveHead', icon = ''}, },
    -- lualine_c = {'filename',"require'lsp-status'.status()", 'FugitiveStatusline()' },
    lualine_c = lualine_diag,
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive', 'fzf'}
}

