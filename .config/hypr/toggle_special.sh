#!/bin/bash
workspace=$(hyprctl activewindow -j | jq -r '.workspace.name')

if [[ "$workspace" == "special:"* ]]; then
    hyprctl dispatch movetoworkspace previous
else
    hyprctl dispatch movetoworkspace special:magic
fi
