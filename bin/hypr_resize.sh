#!/bin/sh

# Old method (kept here for reference)
#hyprctl --batch "keyword misc:animate_manual_resizes true ; dispatch resizeactive $@ ; keyword misc:animate_manual_resizes false"

# Always unset animation resize!
trap 'hyprctl keyword misc:animate_manual_resizes false' EXIT

hyprctl keyword misc:animate_manual_resizes true
hyprctl dispatch resizeactive $@ 
