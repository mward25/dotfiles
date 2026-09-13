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

convert_videos() {
	local -a videos=()
	>&2 printf "\nGetting list of videos... "
	mapfile -d '' videos < <(find "$IMAGE_PATH" -type f \
		\( -iname '*.mp4' \
		-o -iname '*.mkv' \
		-o -iname '*.avi' \
		-o -iname '*.mov' \
		-o -iname '*.webm' \
		\) -print0)

	>&2 printf "Finished!\n"

	>&2 printf "Counting videos... "
	local total_count=${#videos[@]}
	if [[ "$total_count" -eq 0 ]]; then
		>&2 printf 'No videos found to convert.\n'
		return
	fi
	>&2 printf "Finished!"

	local current_index=0
	for video_path in "${videos[@]}"; do
		current_index=$((current_index + 1))
		local base_name
		base_name=$(basename "$video_path")
		local gif_path="${video_path%.*}.gif"

		if [[ -f "$gif_path" ]]; then
			#  Gif already exists.
			>&2 printf "Skipping '%s' [%i/%i] \r" "$base_name" "$current_index" "$total_count"
		else
			>&2 printf "Converting '%s' [%i/%i] \r" "$base_name" "$current_index" "$total_count"
			# Convert the video to a gif.
			ffmpeg -i "$video_path" -f yuv4mpegpipe - 2>/dev/null | \
				gifski -o "$gif_path" --quiet -
		fi
		tput el
	done

	>&2 printf '\n'
}

mapfile -d '' find_args < <(build_find_arguments)

if [[ "$1" == "convert" ]]; then
	convert_videos
	exit 0
fi

while true; do
	find "$IMAGE_PATH" -type f '(' "${find_args[@]}" ')' -print0 | shuf -z | while IFS= read -r -d '' image_path; do
		>&2 echo "Switching to '$image_path'!"
		awww img \
			-t random \
			--resize fit -- "$image_path"
		sleep "$(get_sleep_duration)"
	done
done
