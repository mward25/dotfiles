#!/usr/bin/env bash
# Scrollback pager chooser — launched as a kitty overlay with scrollback piped to stdin.
# Usage: launch --stdin-source=@screen_scrollback --stdin-add-formatting --type=overlay bash ~/.config/kitty/pager_mode.sh

exec 3<&0        # stash scrollback on fd 3
exec 0</dev/tty  # redirect stdin to terminal for keypress

printf "SCROLLBACK:  [e] editor (nvim)  [o] less  [q/ESC] cancel\n"
IFS= read -r -s -n1 key

exec 0<&3        # restore scrollback to stdin
exec 3<&-

case "$key" in
    e)
        perl -pe '
            s/\x1b\[[0-9;:?]*[a-zA-Z]//g;  # CSI: color, cursor, etc.  e.g. \x1b[31m
            s/\x1b\].*?(?:\x07|\x1b\\)//g;  # OSC: hyperlinks, shell integration.  e.g. \x1b]8;;URL\x1b\text\x1b]8;;\x1b\
                                             #   non-greedy .*? stops at first ST (\x1b\) to preserve visible text between sequences
            s/\x1b.//g;                      # catch-all: any remaining \x1b + one char (SS2, SS3, etc.)
        ' | nvim -
        ;;
    o)
        less +G -R
        ;;
esac
