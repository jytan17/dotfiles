#!/usr/bin/env bash
# stash_menu.sh -- display a tmux menu of panes parked in the _stash window.
# Selecting an entry swaps that stash pane with the currently focused pane.
# The swapped-out pane becomes new top of stack.

STASH_WIN="_stash"
STACK_FILE="/tmp/tmux-stash-stack-$(tmux display-message -p '#{session_id}')"

# Bail if stash window doesn't exist or is empty.
if ! tmux list-windows -F '#{window_name}' | grep -q "^${STASH_WIN}$"; then
  tmux display-message "Stash empty — use prefix+S to park a pane first"
  exit 0
fi

pane_count=$(tmux list-panes -t "$STASH_WIN" -F '#{pane_id}' | wc -l)
if [ "$pane_count" -eq 0 ]; then
  tmux display-message "Stash empty"
  exit 0
fi

# Get path to this script's directory for the swap helper.
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# Build menu entries: show pane title (if set) or running command.
menu_args=()
idx=0
while IFS=$'\t' read -r pane_id pane_title pane_cmd; do
  label="${pane_title:-$pane_cmd}"
  # On select: swap pane and update stack file.
  menu_args+=("$label" "$((idx + 1))" "run-shell '$SCRIPT_DIR/stash_swap_by_id.sh $pane_id'")
  idx=$((idx + 1))
done < <(tmux list-panes -t "$STASH_WIN" -F '#{pane_id}	#{pane_title}	#{pane_current_command}')

tmux display-menu -T "Swap from stash" "${menu_args[@]}"
