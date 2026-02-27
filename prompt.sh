c_cyan=$(tput setaf 6)
c_red=$(tput setaf 1)
c_green=$(tput setaf 2)
c_yellow=$(tput setaf 3)
c_blue=$(tput setaf 4)
c_magenta=$(tput setaf 5)
c_white=$(tput setaf 7)
c_bright_blue=$(tput setaf 12)
c_bright_yellow=$(tput setaf 11)
c_bright_red=$(tput setaf 9)
c_bold=$(tput bold)
c_sgr0=$(tput sgr0)

branch_color ()
{
    if git rev-parse --git-dir >/dev/null 2>&1
    then
        color=""
        if git diff --quiet 2>/dev/null >&2
        then
            if git diff --cached --quiet 2>/dev/null >&2; then
                color=${c_green}
            else
                color=${c_yellow}
            fi
        else
            color=${c_red}
        fi
    else
        return 0
    fi
    echo -n $color
}

parse_git_branch ()
{
    if git rev-parse --git-dir >/dev/null 2>&1
    then
        local branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
        [[ ${#branch} -gt 20 ]] && branch="${branch:0:17}..."
        gitver="[${branch}]"
    else
        return 0
    fi
    echo -e $gitver
}

node_prompt_info() {
    if command -v node >/dev/null 2>&1; then
        local node_version=$(node --version 2>/dev/null)
        if [[ -n "$node_version" ]]; then
            echo -n "%{${c_blue}%}[${node_version}]%{${c_sgr0}%} "
        fi
    fi
}

docker_prompt_info() {
    if command -v docker >/dev/null 2>&1; then
        local context=$(docker context show 2>/dev/null)
        if [[ -n "$context" && "$context" != "default" ]]; then
            echo -n "%{${c_bright_blue}%}[${context}]%{${c_sgr0}%} "
        fi
    fi
}

aws_prompt_info() {
    if [[ -n "$AWS_PROFILE" || -n "$AWS_REGION" ]]; then
        local profile="${AWS_PROFILE:-default}"

        if [[ "$profile" == *"prod"* ]]; then
            echo -n "%{${c_bold}${c_red}%}[${profile}]%{${c_sgr0}%} "
        elif [[ "$profile" == *"dev"* ]]; then
            echo -n "%{${c_green}%}[${profile}]%{${c_sgr0}%} "
        elif [[ "$profile" == *"staging"* || "$profile" == *"stage"* ]]; then
            echo -n "%{${c_yellow}%}[${profile}]%{${c_sgr0}%} "
        else
            echo -n "%{${c_cyan}%}[${profile}]%{${c_sgr0}%} "
        fi
    fi
}

show_colors() {
    echo "Standard Colors:"
    for i in {0..7}; do
        echo -e "$(tput setaf $i)Color $i: This is color $i$(tput sgr0)"
    done
    echo -e "\nBright Colors:"
    for i in {8..15}; do
        echo -e "$(tput setaf $i)Color $i: This is bright color $i$(tput sgr0)"
    done
    echo -e "\nText Formatting:"
    echo -e "$(tput bold)Bold text$(tput sgr0)"
    echo -e "$(tput dim)Dim text$(tput sgr0)"
    echo -e "$(tput smul)Underlined text$(tput sgr0)"
    echo -e "$(tput rev)Reversed text$(tput sgr0)"
}

PS1='$(aws_prompt_info)$(node_prompt_info)%n@%{${c_red}%}%1~%{${c_sgr0}%}%{$(branch_color)%}$(parse_git_branch)%{${c_sgr0}%}$ '
