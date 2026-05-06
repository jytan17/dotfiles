#!/usr/bin/env bash
# stash_swap_by_id.sh -- swap a specific stash pane (by ID) with current pane.
# Updates the stack file: removes the selected pane, pushes current pane as new top.
# Called by stash_menu.sh when user picks from the menu.

STASH_WIN="_stash"
STACK_FILE="/tmp/tmux-stash-stack-$(tmux display-message -p '#{session_id}')"
TARGET_ID="$1"

if [ -z "$TARGET_ID" ]; then
  tmux display-message "Error: no pane ID provided"
  exit 1
fi

# Current pane ID (going into stash).
current_id=$(tmux display-message -p '#{pane_id}')

# Swap.
tmux swap-pane -d -s "$TARGET_ID"

# Update stack: remove target (now visible), push current as new top.
if [ -s "$STACK_FILE" ]; then
  new_stack=$(grep -v "^${TARGET_ID}$" "$STACK_FILE")
  if [ -n "$new_stack" ]; then
    echo "$new_stack" > "$STACK_FILE"
  else
    : > "$STACK_FILE"
  fi
else
  : > "$STACK_FILE"
fi
echo "$current_id" >> "$STACK_FILE"
