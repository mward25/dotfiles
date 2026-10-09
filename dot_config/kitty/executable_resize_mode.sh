#!/usr/bin/env bash

# Usage: resize_mode.sh [--amount=N]
# Amount must be a positive integer. Sign is handled internally per direction.

AMOUNT=2
for arg in "$@"; do
  case "$arg" in
  --amount=*)
    AMOUNT="${arg#--amount=}"
    ;;
  esac
done

if ! [[ "$AMOUNT" =~ ^[0-9]+$ ]] || ((AMOUNT <= 0)); then
  echo "resize_mode: --amount must be a positive integer (got: '$AMOUNT')" >&2
  read -r -s -n1
  exit 1
fi

BIG_AMOUNT=$(($AMOUNT * 10))

echo "RESIZE (amount=${AMOUNT}): h/l wider/narrower  k/j taller/shorter  q/ESC/Enter to exit (Shift+these options to do more!)"

ESCAPE_KEY=$'\x1b'
ENTER_KEY=$'\n'

while IFS= read -r -s -N 1 key; do
  case "$key" in
  h) kitty @ resize-window --increment="${AMOUNT}" --axis=horizontal --match "id:${KITTY_WINDOW_ID}" ;;
  l) kitty @ resize-window --increment="-${AMOUNT}" --axis=horizontal --match "id:${KITTY_WINDOW_ID}" ;;
  k) kitty @ resize-window --increment="${AMOUNT}" --axis=vertical --match "id:${KITTY_WINDOW_ID}" ;;
  j) kitty @ resize-window --increment="-${AMOUNT}" --axis=vertical --match "id:${KITTY_WINDOW_ID}" ;;

  H) kitty @ resize-window --increment="${BIG_AMOUNT}" --axis=horizontal --match "id:${KITTY_WINDOW_ID}" ;;
  L) kitty @ resize-window --increment="-${BIG_AMOUNT}" --axis=horizontal --match "id:${KITTY_WINDOW_ID}" ;;
  K) kitty @ resize-window --increment="${BIG_AMOUNT}" --axis=vertical --match "id:${KITTY_WINDOW_ID}" ;;
  J) kitty @ resize-window --increment="-${BIG_AMOUNT}" --axis=vertical --match "id:${KITTY_WINDOW_ID}" ;;
  q | $ENTER_KEY | $ESCAPE_KEY) break ;;
  *) printf "Key '%q' is invalid" "$key"
  esac
done
# $CTRL_H_KEY) kitty @ resize-window --increment="${AMOUNT}" --axis=horizontal --match "id:${KITTY_WINDOW_ID}" ;;
# $CTRL_L_KEY) kitty @ resize-window --increment="-${AMOUNT}" --axis=horizontal --match "id:${KITTY_WINDOW_ID}" ;;
# $CTRL_K_KEY) kitty @ resize-window --increment="${AMOUNT}" --axis=vertical --match "id:${KITTY_WINDOW_ID}" ;;
# $CTRL_J_KEY) kitty @ resize-window --increment="-${AMOUNT}" --axis=vertical --match "id:${KITTY_WINDOW_ID}" ;;
