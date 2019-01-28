tmux new-session -s test -n console -d
tmux split-window -v -t test
tmux split-window -h -t test
tmux split-window -p 30 -h -t test:1.1
tmux attach -t test
