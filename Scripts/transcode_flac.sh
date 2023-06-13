#!/bin/zsh

transcode_options=('16-48' '16-44.1')
SOURCE_DIR=${1///}
DESTINATION_DIR=${2///}
TRANSCODE=$3

usage() {
  echo "Usage: $0 [source folder] [destination folder] [encode option]"
}

check_transcode_options() {
  for option in "${transcode_options[@]}"; do
    if [[ "$1" == "$option" ]]; then
      return 0
    fi
  done
  echo "Invalid transcode option"
  exit 1
}

convert() {
  echo "$file"
  if [[ "$1" == "16-48" ]]; then
    sox "$file" -G -b 16 "$DESTINATION_DIR/$output" rate -v -L 48000 dither
  elif [[ "$1" == "16-44.1" ]]; then
    sox "$file" -G -b 16 "$DESTINATION_DIR/$output" rate -v -L 44100 dither
  else
    echo "Not valid transcode option"
  fi
}

# Step 1: Checking inputs
if [[ $# -ne 3 ]]; then
  usage
  exit 1
fi

check_transcode_options "$TRANSCODE"
echo "Valid transcode option"

# Step 2: Copying non-FLAC files
echo "Copying non-FLAC files"
rsync -a --exclude="*.flac" "$1/" "$DESTINATION_DIR"

for file in "$SOURCE_DIR"/*.flac; do
  output=${file/"$1"/}

  # Step 3: Transcoding files
  convert "$TRANSCODE"
done
