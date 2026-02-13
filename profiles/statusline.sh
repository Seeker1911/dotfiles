#!/bin/bash
# Claude Code statusline — shows AWS profile, Node version, git branch, and context usage

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# Colors
c_red=$(tput setaf 1)
c_green=$(tput setaf 2)
c_yellow=$(tput setaf 3)
c_blue=$(tput setaf 4)
c_cyan=$(tput setaf 6)
c_magenta=$(tput setaf 5)
c_bold=$(tput bold)
c_dim=$(tput dim)
c_sgr0=$(tput sgr0)

# --- AWS profile ---
aws_info=''
if [[ -n "$AWS_PROFILE" ]]; then
    profile="$AWS_PROFILE"
    if [[ "$profile" == *"prod"* ]]; then
        aws_info="${c_bold}${c_red}[${profile}]${c_sgr0} "
    elif [[ "$profile" == *"dev"* ]]; then
        aws_info="${c_green}[${profile}]${c_sgr0} "
    elif [[ "$profile" == *"staging"* || "$profile" == *"stage"* ]]; then
        aws_info="${c_yellow}[${profile}]${c_sgr0} "
    else
        aws_info="${c_cyan}[${profile}]${c_sgr0} "
    fi
fi

# --- Node.js version ---
node_info=''
if command -v node >/dev/null 2>&1; then
    node_version=$(node --version 2>/dev/null)
    if [[ -n "$node_version" ]]; then
        node_info="${c_blue}[${node_version}]${c_sgr0} "
    fi
fi

# --- Git branch + status ---
git_info=''
if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
    if git -C "$cwd" diff --quiet 2>/dev/null && git -C "$cwd" diff --cached --quiet 2>/dev/null; then
        git_color="${c_green}"
    elif git -C "$cwd" diff --cached --quiet 2>/dev/null; then
        git_color="${c_red}"
    else
        git_color="${c_yellow}"
    fi
    branch=$(git -C "$cwd" branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
    git_info="${git_color}[${branch}]${c_sgr0} "
fi

# --- Context window usage ---
ctx_info=''
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [[ -n "$used_pct" ]]; then
    # Round to integer
    pct_int=$(printf "%.0f" "$used_pct")

    # Color by usage level
    if (( pct_int >= 80 )); then
        ctx_color="${c_bold}${c_red}"
    elif (( pct_int >= 50 )); then
        ctx_color="${c_yellow}"
    else
        ctx_color="${c_green}"
    fi
    ctx_info="${ctx_color}ctx:${pct_int}%${c_sgr0} "
fi

# --- Cost ---
cost_info=''
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
if [[ -n "$cost" && "$cost" != "0" ]]; then
    cost_fmt=$(printf "\$%.2f" "$cost")
    cost_info="${c_dim}${cost_fmt}${c_sgr0} "
fi

# --- Build output ---
printf "%s%s%s@%s%s%s %s%s%s" \
    "$aws_info" \
    "$node_info" \
    "$(whoami)" \
    "${c_red}" \
    "$(basename "$cwd")" \
    "${c_sgr0}" \
    "$git_info" \
    "$ctx_info" \
    "$cost_info"
