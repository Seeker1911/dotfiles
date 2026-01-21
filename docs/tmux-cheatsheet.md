# tmux Cheatsheet

## Config Location
- Main config: `~/.tmux.conf` (symlinked from `~/dotfiles/tmux.conf`)
- Theme files: `~/dotfiles/colors/tmux-*.conf` (not currently sourced)
- Theme toggle script: `~/dotfiles/bin/tmux-theme.sh`

---

## Prefix Key

**`Ctrl+a`** (not the default `Ctrl+b`)

---

## Pane Management (no prefix needed)

| Keys | Action |
|------|--------|
| `Alt+\` | Split horizontal |
| `Alt+-` | Split vertical |
| `Alt+h/j/k/l` | Navigate panes (vim-style) |
| `Alt+Shift+J/K` | Swap pane up/down |
| `Ctrl+Alt+h/j/k/l` | Resize pane |
| `Alt+m` | Toggle pane fullscreen (zoom) |

---

## Window Management (no prefix needed)

| Keys | Action |
|------|--------|
| `Alt+n` | Next window |
| `Alt+p` | Previous window |
| `Alt+1-9` | Jump to window 1-9 |
| `Alt+Shift+H/L` | Swap window position |

---

## Layouts (no prefix needed)

| Keys | Action |
|------|--------|
| `Alt+v` | Main vertical layout |
| `Alt+z` | Main horizontal layout |
| `Alt+Shift+V` | Even vertical |
| `Alt+Shift+Z` | Even horizontal |

---

## Prefix Commands (`Ctrl+a` first)

| Keys | Action |
|------|--------|
| `n` | New window |
| `p` | Split vertical |
| `r` | Reload config |
| `d` | Detach from session |
| `x` | Kill current pane |
| `&` | Kill current window |
| `w` | List windows |
| `s` | List sessions |
| `,` | Rename current window |
| `$` | Rename current session |
| `[` | Enter copy mode |
| `]` | Paste buffer |
| `?` | List all keybindings |
| `t` | Show clock |
| `q` | Show pane numbers |

---

## Copy Mode (vim keys)

Enter copy mode: `prefix + [`

| Keys | Action |
|------|--------|
| `Space` | Begin selection |
| `v` | Begin selection (visual) |
| `y` | Yank to system clipboard |
| Mouse drag | Select and copy to clipboard (on release) |
| `q` or `Escape` | Exit copy mode |
| `/` | Search forward |
| `?` | Search backward |
| `n` | Next search match |
| `N` | Previous search match |
| `h/j/k/l` | Navigate |
| `Ctrl+u/d` | Page up/down |
| `g` | Go to top |
| `G` | Go to bottom |

---

## Session Management (CLI)

```bash
# Start new session
tmux new -s <name>

# List sessions
tmux ls

# Attach to session
tmux attach -t <name>
tmux a -t <name>

# Kill session
tmux kill-session -t <name>

# Kill all sessions
tmux kill-server

# Detach other clients (attach exclusively)
tmux attach -dt <name>
```

---

## Window/Pane Commands (CLI)

```bash
# New window in current session
tmux new-window -n <name>

# Send keys to a pane
tmux send-keys -t <session>:<window>.<pane> "command" Enter

# Capture pane contents
tmux capture-pane -p > output.txt
```

---

## Plugins (via TPM)

- **tmux-resurrect**: Persist sessions across restarts
- **tmux-continuum**: Auto-save every 5 min
- **tmux-yank**: Copy to system clipboard

| Keys | Action |
|------|--------|
| `prefix + Ctrl+s` | Save session |
| `prefix + Ctrl+r` | Restore session |

### Installing new plugins
1. Add plugin to `tmux.conf`: `set -g @plugin 'user/repo'`
2. Reload config: `prefix + r`
3. Install: `prefix + I`

### TPM commands
| Keys | Action |
|------|--------|
| `prefix + I` | Install plugins |
| `prefix + U` | Update plugins |
| `prefix + Alt+u` | Uninstall removed plugins |

---

## Theme

Currently using **Gruvbox Dark** (hardcoded in tmux.conf):

| Element | Colors |
|---------|--------|
| Status bar bg | `#1d1d1d` |
| Session label | `#83a598` blue / `#d8a657` gold |
| Inactive window | `#b16286` purple / `#d3869b` pink |
| Active window | `#689d6a` / `#8ec07c` green |
| Active pane border | `#8ec07c` green |

To switch themes, source a different file:
```bash
# In tmux.conf
source-file ~/dotfiles/colors/tmux-catpuccin.conf
```

---

## Useful Tips

```bash
# Show all options
tmux show-options -g

# Show all keybindings
tmux list-keys

# Run command in all panes
tmux setw synchronize-panes on
# (type command, then turn off)
tmux setw synchronize-panes off

# Clear pane history
tmux clear-history
```
