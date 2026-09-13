#!/bin/env bash

IMAGE_PATH="$HOME/Pictures/backgrounds/"

SUPPORTED_FORMATS=(
	avif
	jpeg
	jpg
	jpegxl
	png
	gif
	pnm
	tga
	tiff
	webp
	bmp
	farbfeld
	svg
)
SUPPORTED_FORMATS+=("${SUPPORTED_FORMATS[@]^^}")


# # Seed random with time.
# RANDOM=$(date +%s)

get_sleep_duration() {
	# Sleep goes from one minute to 20 minutes
	local sleep_low="60"
	local sleep_high="$(( 60 * 20))"
	# printf "%s" "$(($RANDOM%sleekj
	shuf -i $sleep_low-$sleep_high -n 1
}

build_find_arguments() {
	local args=()

	for format in "${SUPPORTED_FORMATS[@]}"; do
		args+=('-iname' "*.${format}")
		args+=('-o')
	done

	unset 'args[-1]'
	printf '%s\0' "${args[@]}"
}

mapfile -d '' find_args < <(build_find_arguments)

while true; do
	find "$IMAGE_PATH" -type f '(' "${find_args[@]}" ')' -print0 | shuf -z | while IFS= read -r -d '' image_path; do
		awww img -t random -- "$image_path"
		sleep "$(get_sleep_duration)"
	done
done
