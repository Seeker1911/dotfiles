#!/bin/bash

_TMUX_NAME="slackterm"

function _startSlack() {
    i=0
    for config in $( ls ~/.config/slack-term/ ); do
        if [[ "$i" -eq "0" ]]; then
            echo "first time through"
            tmux new-window -n ${_TMUX_NAME}
            tmux split-window -v
            tmux split-window -h
        fi
        i=$(( $i + 1 ))
        name=$( basename $config | cut -d. -f1 )
        tmux send-keys -t ${_TMUX_NAME}.$i "slack-term --config ~/.config/slack-term/${name}" C-m
        echo "name is ... " $name
    done
}

_startSlack
