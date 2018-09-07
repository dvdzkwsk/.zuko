#!/bin/bash

command -v tmux >/dev/null 2>&1 || { printf "Cockpit requires tmux but it is not installed.
Please check http://cockpit.27ae60.com/help.html for more information.
Aborting." >&2; exit 1; }

SESSION=session

# if the session is already running, just attach to it.
tmux has-session -t $SESSION
if [ $? -eq 0 ]; then
  echo "Session $SESSION already exists. Attaching."
  sleep 1
  tmux -2 attach -t $SESSION
  exit 0;
fi

# create a new session, named $SESSION, and detach from it
tmux -2 new-session -d -s $SESSION

# Now populate the session with the windows you use every day
tmux set-option -g base-index 1
tmux set-window-option -t $SESSION -g automatic-rename off
tmux set-window-option -g pane-base-index 1

tmux new-window -t $SESSION:0 -k -n teams-modular-packages-
tmux send-keys -t ${window}.1 '' Enter
tmux new-window -t $SESSION:1 -k -n teams-lite-
tmux send-keys -t ${window}.1 'z lite' Enter
tmux set-window-option -t $SESSION:0 automatic-rename off

# all done. select starting window and get to work
tmux select-window -t $SESSION:0
tmux -2 attach -t $SESSION
