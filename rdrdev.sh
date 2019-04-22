#! /bin/bash

function setup {
    tmux new-session -s rdr -n console -d
    tmux split-window -v -t rdr
    tmux split-window -h -t rdr
    tmux split-window -p 30 -h -t rdr:1.1
    tmux split-window -h -t rdr:1.3
    #tmux select-layout -t rdr main-horizontal
    tmux send-keys -t rdr:1.1 'cd ~/code/raw-data-repository' C-m
    tmux send-keys -t rdr:1.1 'wtf -c~/.config/wtf/liteconfig.yml' C-m
    tmux send-keys -t rdr:1.2 'cd ~/code/raw-data-repository/rest-api' C-m
    tmux send-keys -t rdr:1.2 'dev_appserver.py test.yaml' C-m
    tmux send-keys -t rdr:1.3 'cd ~/code/raw-data-repository' C-m
    tmux send-keys -t rdr:1.3 'gcloud alpha interactive' C-m
    tmux send-keys -t rdr:1.4 'cd ~/code/raw-data-repository' C-m
    tmux send-keys -t rdr:1.4 'git status' C-m
    tmux send-keys -t rdr:1.5 'cd ~/code/raw-data-repository' C-m
    sleep 1
    tmux send-keys -t rdr:1.5 'cd rest-api' C-m
    tmux send-keys -t rdr:1.5 './test/run_tests.sh -g $sdk_dir' C-m
    tmux new-window -n editor -t rdr
    tmux send-keys -t rdr:2 'cd ~/code/raw-data-repository' C-m
    tmux select-window -t rdr:1
}

tmux has-session -t rdr
if [ $? != 0 ]
then
    tmux detach
    setup
else
    tmux detach
    tmux kill-session -t rdr
    setup
fi
tmux attach -t rdr
