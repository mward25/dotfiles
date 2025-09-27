#!/bin/bash

summary="$2"
body="$3"

#echo "$summary $body" | awk 'BEGIN{RS=""; ORS="\n"} {gsub(/\n/, " "); print}' | mimic --voice en_UK/apope_low  | paplay --volume=29538
