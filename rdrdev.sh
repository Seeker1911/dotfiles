#! /bin/bash

function setup {
    tmux new-session -s development -n console -d
    tmux split-window -v -t development
    tmux split-window -h -t development
    tmux select-layout -t development main-horizontal
    tmux send-keys -t development:1.1 'cd ~/code/raw-data-repository' C-m
    tmux send-keys -t development:1.1 'source rdr_client/venv/bin/activate' C-m
    tmux send-keys -t development:1.1 'wtf' C-m
    tmux send-keys -t development:1.2 'cd ~/code/raw-data-repository' C-m
    tmux send-keys -t development:1.2 'source rdr_client/venv/bin/activate' C-m
    tmux send-keys -t development:1.2 'dev_appserver test.yaml' C-m
    tmux send-keys -t development:1.3 'cd ~/code/raw-data-repository' C-m
    tmux send-keys -t development:1.3 'source rdr_client/venv/bin/activate' C-m
    tmux send-keys -t development:1.3 'gcloud alpha interactive' C-m
    tmux new-window -n editor -t development
    tmux send-keys -t development:2 'cd ~/code/raw-data-repository' C-m
    tmux send-keys -t development:2 'source rdr_client/venv/bin/activate' C-m
    tmux select-window -t development:1
}

tmux has-session -t development
if [ $? != 0 ]
then
    setup
else
    tmux kill-session -t development
fi
tmux attach -t development

