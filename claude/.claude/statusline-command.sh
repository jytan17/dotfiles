#!/usr/bin/env bash

# Catppuccin Mocha palette via truecolor escape sequences
# Usage: printf "${BLUE}text${RESET}"
RESET="\033[0m"
BOLD="\033[1m"
# Mocha Blue  #89b4fa → r=137 g=180 b=250
BLUE="\033[38;2;137;180;250m"
# Mocha Green #a6e3a1 → r=166 g=227 b=161
GREEN="\033[38;2;166;227;161m"
# Mocha Yellow #f9e2af → r=249 g=226 b=175
YELLOW="\033[38;2;249;226;175m"
# Mocha Peach #fab387 → r=250 g=179 b=135  (model tag)
ORANGE="\033[38;2;250;179;135m"
# Mocha Surface2 #585b70 → r=88 g=91 b=112  (dimmed separators)
DIM="\033[38;2;88;91;112m"

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name // empty')

# Shorten directory path
dir="$cwd"
home="$HOME"
[[ "$dir" == "$home" ]] && dir="~" || [[ "$dir" == "$home"/* ]] && dir="~${dir#$home}"
[ ${#dir} -gt 40 ] && dir="...${dir: -37}"

# Git info — plain text style: "git <branch>" with status glyphs matching starship
# Clean branch: bold green   Dirty branch: bold yellow with status
git_info=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null || echo "detached")
  staged=$(git -C "$cwd" --no-optional-locks diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
  unstaged=$(git -C "$cwd" --no-optional-locks diff --numstat 2>/dev/null | wc -l | tr -d ' ')
  untracked=$(git -C "$cwd" --no-optional-locks ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')
  # Status glyphs match starship git_status: + staged, ! modified, ? untracked
  status=""
  [ "$staged" -gt 0 ]    && status="${status}+${staged}"
  [ "$unstaged" -gt 0 ]  && status="${status}!${unstaged}"
  [ "$untracked" -gt 0 ] && status="${status}?${untracked}"
  if [ -n "$status" ]; then
    git_info=$(printf " ${BOLD}${GREEN}git %s${RESET} ${BOLD}${YELLOW}%s${RESET}" "$branch" "$status")
  else
    git_info=$(printf " ${BOLD}${GREEN}git %s${RESET}" "$branch")
  fi
fi

# Model info — Catppuccin Mocha Peach (orange), bold, first in line
model_info=""
if [ -n "$model" ]; then
  model_info=$(printf "${BOLD}${ORANGE}%s${RESET}" "$model")
fi

# Layout: model  bold-blue-dir  git-info
printf "%s ${BOLD}${BLUE}%s${RESET}%s" \
  "$model_info" "$dir" "$git_info"
