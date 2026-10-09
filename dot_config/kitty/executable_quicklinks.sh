#!/usr/bin/env bash

declare -A quicklinks
quicklinks=(
  ["Git"]="lazygit"
  ["Files"]="yazi"
  ["Editor"]="nvim"
)

to_launch="$( printf "%s\0" "${!quicklinks[@]}" | fzf --read0 )"

kitten @ launch --type=tab --cwd=current -- "${quicklinks[$to_launch]}"

#
# IFS='' echo "${!quicklinks[*]}"

