#!/bin/zsh

transcode_options=('320' 'V0' 'V2')
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
  if [[ "$1" == "320" ]]; then
    sox -G "$file" -t wav -r 44100 - | lame -b 320 --add-id3v2 - "$DESTINATION_DIR/$output" --tt "$TITLE" --ta "$ARTIST" --tl "$ALBUM" --ty "$YEAR" --tn "$TRACKNUMBER/$TOTAL" --tg "$GENRE"
  elif [[ "$1" == "V0" ]]; then
    sox -G "$file" -t wav -r 44100 - | lame -V 0 --add-id3v2 - "$DESTINATION_DIR/$output" --tt "$TITLE" --ta "$ARTIST" --tl "$ALBUM" --ty "$YEAR" --tn "$TRACKNUMBER/$TOTAL" --tg "$GENRE"
  elif [[ "$1" == "V2" ]]; then
    sox -G "$file" -t wav -r 44100 - | lame -V 2 --add-id3v2 - "$DESTINATION_DIR/$output" --tt "$TITLE" --ta "$ARTIST" --tl "$ALBUM" --ty "$YEAR" --tn "$TRACKNUMBER/$TOTAL" --tg "$GENRE"
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
  output=${output/flac/mp3}

  # Step 3: Copying tags
  ARTIST=$(metaflac "$file" --show-tag=ARTIST | sed 's/\w*=//g')
  TITLE=$(metaflac "$file" --show-tag=TITLE | sed 's/\w*=//g')
  ALBUM=$(metaflac "$file" --show-tag=ALBUM | sed 's/\w*=//g')
  GENRE=$(metaflac "$file" --show-tag=GENRE | sed 's/\w*=//g')
  TOTAL=$(ls -l "$SOURCE_DIR"/*flac | wc -l)
  TRACKNUMBER=$(metaflac "$file" --show-tag=TRACKNUMBER | sed 's/\w*=//g')
  YEAR=$(metaflac "$file" --show-tag=DATE | sed 's/\w*=//g')

  # Step 4: Transcoding files
  convert "$TRANSCODE"
done
