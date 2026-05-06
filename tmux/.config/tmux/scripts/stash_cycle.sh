#!/usr/bin/env bash
# stash_cycle.sh -- swap focused pane with TOP of stash stack.
# The pane going INTO stash becomes new top. Repeated Tab = toggle.
# Stack order tracked in file, not tmux pane indices.

STASH_WIN="_stash"
STACK_FILE="/tmp/tmux-stash-stack-$(tmux display-message -p '#{session_id}')"

if [ ! -s "$STACK_FILE" ]; then
  tmux display-message "Stash empty — use prefix+S to park a pane first"
  exit 0
fi

# Validate: remove any pane IDs that no longer exist in _stash.
if tmux list-windows -F '#{window_name}' | grep -q "^${STASH_WIN}$"; then
  live_panes=$(tmux list-panes -t "$STASH_WIN" -F '#{pane_id}')
else
  tmux display-message "Stash empty"
  : > "$STACK_FILE"
  exit 0
fi

# Filter stack to only living panes.
filtered=""
while IFS= read -r id; do
  if echo "$live_panes" | grep -q "^${id}$"; then
    filtered="${filtered}${id}"$'\n'
  fi
done < "$STACK_FILE"
filtered=$(echo -n "$filtered" | sed '/^$/d')

if [ -z "$filtered" ]; then
  tmux display-message "Stash empty"
  : > "$STACK_FILE"
  exit 0
fi

# Top of stack = last line.
top_id=$(echo "$filtered" | tail -1)

# Current pane ID (the one going into stash).
current_id=$(tmux display-message -p '#{pane_id}')

# Swap.
tmux swap-pane -d -s "$top_id"

# Update stack: remove top_id (it's now visible), push current_id as new top.
new_stack=$(echo "$filtered" | sed "\|^${top_id}$|d")
if [ -n "$new_stack" ]; then
  echo "$new_stack" > "$STACK_FILE"
else
  : > "$STACK_FILE"
fi
echo "$current_id" >> "$STACK_FILE"
