#!/bin/bash

set -e

workspaces=$(hyprctl workspaces -j | jq '.[] | "\(.name) - \(.monitor) - ID:\(.id)"' )
selection=$(echo "$workspaces" | kickoff --from-stdin --stdout --prompt "Select Workspace:  ")
test -n "$selection"

id=$(echo "$selection" | awk -F ':' '{print $NF}')
name=$(echo "$selection" | awk -F ' -' '{print $1}')

# Check if workspace is a named workspace
if [ "$id" -le -1337 ]; then
  goto="name:$name"
else
  goto="$id"
fi

hyprctl dispatch workspace "$goto"