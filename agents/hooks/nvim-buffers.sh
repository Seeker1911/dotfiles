#!/usr/bin/env bash

sockets=$(lsof -c nvim 2>/dev/null | awk '/nvim\.[0-9]+\.0$/ {print $NF}')

[ -z "$sockets" ] && echo "No running Neovim instances found." && exit 0

i=1
while IFS= read -r socket; do
  pid=$(echo "$socket" | grep -oE 'nvim\.[0-9]+' | grep -oE '[0-9]+')
  cwd=$(lsof -p "$pid" -a -d cwd -Fn 2>/dev/null | awk '/^n/ {print substr($0,2)}')

  buffers=$(nvim --server "$socket" --remote-expr 'execute("ls")' 2>/dev/null)
  [ -z "$buffers" ] && continue

  echo "Neovim #$i (PID $pid${cwd:+, cwd: $cwd}):"
  echo "$buffers"
  echo ""
  i=$((i + 1))
done <<< "$sockets"
