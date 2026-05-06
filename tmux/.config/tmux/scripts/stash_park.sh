#!/usr/bin/env bash
# stash_park.sh -- move the focused pane into the _stash window.
# Creates _stash if it doesn't exist (via break-pane).
# Disables automatic-rename on _stash so the name stays stable.
# A new shell replaces the parked pane so the layout stays intact.
# Tracks stash order in a stack file (most recent = last line).

STASH_WIN="_stash"
STACK_FILE="/tmp/tmux-stash-stack-$(tmux display-message -p '#{session_id}')"

# Remember current pane's ID and directory.
pane_id=$(tmux display-message -p '#{pane_id}')
pane_path=$(tmux display-message -p '#{pane_current_path}')

# Check if _stash window exists (by name).
if tmux list-windows -F '#{window_name}' | grep -q "^${STASH_WIN}$"; then
  tmux join-pane -d -t "$STASH_WIN"
else
  tmux break-pane -d -n "$STASH_WIN"
  tmux set-option -t "$STASH_WIN" automatic-rename off
fi

# Push pane ID onto stack (append = top).
echo "$pane_id" >> "$STACK_FILE"

# Split a new shell in the spot that was just vacated.
tmux split-window -h -c "$pane_path"
