#!/bin/bash
# hypr_zoom.sh - Adjust Hyprland cursor zoom factor
# Usage: hypr_zoom.sh in|out

ZOOM_FILE="/tmp/hypr_zoom_factor"
STEP=0.1
MIN=1.0
MAX=5.0

if [ -f "$ZOOM_FILE" ]; then
    CURRENT=$(cat "$ZOOM_FILE")
else
    CURRENT=1.0
fi

case "$1" in
    in)
        NEW=$(awk "BEGIN { v = $CURRENT + $STEP; print (v > $MAX ? $MAX : v) }")
        ;;
    out)
        NEW=$(awk "BEGIN { v = $CURRENT - $STEP; print (v < $MIN ? $MIN : v) }")
        ;;
    *)
        echo "Usage: $0 [in|out]"
        exit 1
        ;;
esac

echo "$NEW" > "$ZOOM_FILE"
hyprctl keyword cursor:zoom_factor "$NEW"
