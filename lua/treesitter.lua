require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {"help", "python", "typescript", "javascript", "go", "lua"},

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_intall = false,

  -- List of parsers to ignore installing
  -- ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    -- disable = { "c", "rust" },

  },
  indent = {
      enable = false,
  },
  -- rainbow parens using treesitter is supplied by nvim-ts-rainbow
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than n lines, int
  }
}
