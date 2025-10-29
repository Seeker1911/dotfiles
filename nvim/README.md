# Neovim Configuration

A modern, highly customized Neovim configuration featuring LSP, code completion, Git integration, and AI-assisted coding. Built with [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager.

## Features

- **Plugin Manager**: lazy.nvim with 46+ plugins
- **LSP Support**: 6 language servers (Lua, TypeScript, Python, HTML, Svelte)
- **Code Completion**: nvim-cmp with multiple sources + GitHub Copilot
- **AI Integration**: GitHub Copilot + CodeCompanion (OpenAI)
- **Git Workflow**: Fugitive, Gitsigns, LazyGit, Twiggy, Octo
- **Formatters**: Conform.nvim (stylua, eslint_d, ruff, prettier)
- **File Navigation**: Telescope fuzzy finder + NvimTree
- **Theme**: Cyberdream with automatic terminal sync (Ghostty)
- **Python Focus**: Dual LSP setup (Ruff + pylsp) with auto-format

## Requirements

### Core Dependencies
- **Neovim** >= 0.10.0
- **Git** >= 2.19.0
- **Node.js** >= 18.x (for LSP servers)
- **Python** >= 3.9
- **Ripgrep** (for Telescope live_grep)
- **FZF** (for telescope-fzf-native)

### Language Tools
- **Ruff** - Python linter/formatter (via pip or package manager)
- **LazyGit** - Git TUI (optional, for lazygit.nvim)
- **1Password CLI** - For CodeCompanion API key (optional)

### Install Dependencies (macOS)
```bash
# Core tools
brew install neovim ripgrep fzf lazygit

# Python tools
pip install ruff python-lsp-server

# Node.js (if not installed)
brew install node
```

## Installation

### 1. Clone Configuration
```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this repo
git clone <your-repo-url> ~/dotfiles

# Run symlink script
cd ~/dotfiles
./makesymlinks.sh
```

### 2. Install Plugins
```bash
# Open Neovim (plugins will auto-install on first launch)
nvim

# Or manually trigger install
nvim +Lazy
```

### 3. Install LSP Servers
LSP servers are managed by Mason. Install them with:
```vim
:Mason
```

Required servers (auto-install configured):
- lua-language-server
- typescript-language-server
- vscode-eslint-language-server
- vscode-html-language-server
- svelte-language-server
- python-lsp-server
- ruff (LSP mode)

### 4. Configure Ruff (Python)
Ruff config is symlinked from `~/dotfiles/config/ruff/pyproject.toml` to `~/.config/ruff/pyproject.toml`. Edit the source file to customize.

## Configuration Structure

```
nvim/
├── init.lua                 # Entry point
├── lazy-lock.json          # Plugin version lockfile
├── lua/
│   ├── options.lua         # Vim options & theme detection
│   ├── mappings.lua        # Keybindings (organized by category)
│   ├── autocommands.lua    # Autocommands & user commands
│   ├── configs/            # Plugin configurations
│   │   ├── cmp.lua
│   │   ├── conform.lua
│   │   ├── gitsigns.lua
│   │   ├── lspconfig.lua
│   │   ├── telescope.lua
│   │   ├── treesitter.lua
│   │   └── ... (16 files total)
│   └── plugins/            # Plugin declarations
│       ├── init.lua        # Main plugin list
│       └── ... (10 files total)
└── README.md
```

## Key Bindings

**Leader key:** `,`

### File Operations
- `<leader>w` - Save file
- `<leader>q` - Quit window
- `<leader>x` - Save and quit

### Navigation
- `<C-h/j/k/l>` - Switch windows
- `<C-n>` - Toggle file tree
- `<leader>e` - Focus file tree
- `<Tab>` / `<S-Tab>` - Next/previous buffer

### Telescope (All `<leader>f*`)
- `<leader>ff` - Find files
- `<leader>fa` - Find all (hidden/ignored)
- `<leader>fw` - Live grep search
- `<leader>fb` - Find buffers
- `<leader>fh` - Search help
- `<leader>fk` - Find keymaps
- `<leader>fz` - Fuzzy find in buffer

### LSP
- `gd` - Go to definition
- `gr` - Show references
- `gi` - Go to implementation
- `<leader>rn` - Rename symbol (inc-rename)
- `<leader>ca` - Code action
- `<leader>fm` - Format file
- `gl` - Open diagnostic float
- `[d` / `]d` - Previous/next diagnostic

### Git
- `<leader>lg` - LazyGit
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>hp` - Preview hunk
- `<leader>hb` - Blame line
- `[c` / `]c` - Previous/next hunk

### Python (Ruff)
- `<leader>rf` - Ruff fix and format
- `<leader>rl` - Ruff lint only

### Terminal
- `<Esc>i` - Toggle floating terminal
- `jj` (in terminal) - Escape terminal mode

### Other
- `<leader>tt` - Toggle theme mode (light/dark)
- `<leader>/` - Toggle comment
- `<Space>` - Toggle fold
- `jj` - Escape insert mode

For complete keybindings, see [`lua/mappings.lua`](lua/mappings.lua) or run `:Telescope keymaps`.

## Plugin List

### Core Infrastructure
- **lazy.nvim** - Plugin manager
- **plenary.nvim** - Lua utility library
- **nvim-web-devicons** - File icons

### Theme & UI
- **cyberdream.nvim** - Primary theme (supports light/dark)
- **gruvbox.nvim**, **zenbones.nvim** - Alternative themes
- **lualine.nvim** - Status line
- **indent-blankline.nvim** - Indent guides
- **noice.nvim** - Enhanced UI (cmd line, notifications)
- **which-key.nvim** - Keybinding hints

### LSP & Code Intelligence
- **nvim-lspconfig** - LSP configuration
- **mason.nvim** - LSP/tool installer
- **nvim-cmp** - Completion engine
- **LuaSnip** - Snippet engine
- **friendly-snippets** - Snippet collection
- **nvim-autopairs** - Auto-pair brackets

### Formatting & Linting
- **conform.nvim** - Formatter (stylua, eslint_d, ruff, prettier)
- **ts-comments.nvim** - Treesitter-aware comments

### Syntax & Treesitter
- **nvim-treesitter** - Syntax highlighting
- **vim-svelte-plugin** - Svelte support

### Git Integration
- **gitsigns.nvim** - Git decorations
- **vim-fugitive** - Git commands
- **vim-rhubarb** - GitHub integration
- **vim-twiggy** - Branch management
- **lazygit.nvim** - LazyGit TUI
- **octo.nvim** - GitHub issues/PRs

### AI & Code Assistance
- **copilot.vim** - GitHub Copilot
- **codecompanion.nvim** - AI chat (OpenAI)

### File Navigation
- **telescope.nvim** - Fuzzy finder
- **nvim-tree.lua** - File explorer

### Utilities
- **toggleterm.nvim** - Terminal integration
- **trouble.nvim** - Diagnostic list
- **inc-rename.nvim** - LSP rename UI
- **minty** - Color picker
- **render-markdown.nvim** - Markdown rendering

## LSP Configuration

### Configured Servers
1. **lua_ls** - Lua (with Neovim API support)
2. **ts_ls** - TypeScript/JavaScript
3. **eslint** - Linting (JS/TS/Vue/Svelte)
4. **html** - HTML
5. **svelte** - Svelte framework
6. **ruff** - Python linting/formatting
7. **pylsp** - Python completion/imports

### Python Dual LSP Setup
This config uses both Ruff and pylsp for Python:
- **Ruff**: Fast linting and formatting
- **pylsp**: Code completion and imports

Auto-format on save is enabled for Python files.

## Theme System

The config automatically detects your terminal theme from Ghostty config and syncs Neovim theme accordingly.

### Supported Themes
- **cyberdream** / **cyberdream-light**
- **gruvbox-dark**
- **GitHub-Dark-Default**
- **github** (light)

### Toggle Theme
- `:CyberdreamToggleMode` or `<leader>tt`

## Customization

### Adding Plugins
Edit `lua/plugins/init.lua` or create a new file in `lua/plugins/`:

```lua
return {
  {
    "author/plugin-name",
    event = "BufRead",
    config = function()
      require("plugin-name").setup({})
    end,
  },
}
```

### Adding Keymaps
Edit `lua/mappings.lua`:

```lua
map("n", "<leader>key", "<cmd>Command<CR>", { desc = "Tool: description" })
```

### Adding LSP Server
1. Add to Mason (`:Mason`)
2. Configure in `lua/configs/lspconfig.lua`

### Changing Formatters
Edit `lua/configs/conform.lua`:

```lua
formatters_by_ft = {
  your_language = { "formatter_name" },
}
```

## Maintenance

### Update Plugins
```vim
:Lazy update
```

### Update LSP Servers
```vim
:Mason
```
Then press `U` to update all.

### Clean Unused Plugins
```vim
:Lazy clean
```

### Check Health
```vim
:checkhealth
```

## Troubleshooting

### LSP Not Working
1. Check server installed: `:Mason`
2. Check LSP attached: `:LspInfo`
3. Restart LSP: `:LspRestart`

### Formatter Not Working
1. Check conform config: `:ConformInfo`
2. Verify formatter in PATH: `which ruff`
3. Check format-on-save: Look for `format_on_save` in `conform.lua`

### Telescope Errors
1. Ensure ripgrep installed: `which rg`
2. Rebuild fzf-native: `:Telescope fzf`

### Theme Not Syncing
1. Check Ghostty config: `~/.config/ghostty/config`
2. Verify theme name matches pattern in `lua/options.lua`

## Performance

### Startup Time
Current config loads in ~50-100ms (on SSD with lazy loading).

Check with:
```bash
nvim --startuptime startup.log
```

### Optimization Features
- Lazy loading (most plugins load on-demand)
- Disabled built-in plugins (netrw, etc.)
- Mason concurrent installs (10 max)
- Scheduled keymap loading


## License

Unlicense (Public Domain) - See [LICENSE](LICENSE)
