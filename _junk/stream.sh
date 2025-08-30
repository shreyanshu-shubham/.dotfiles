#!/bin/bash

LIST_STREAMS=0
LIST_STREAMS_EXTENSION="mkv"
GREP_STRING=
WORKING_DIRECTORY="."

HELP_MESSAGE="

"

if [ $# -eq 0 ];then
    echo "${HELP_MESSAGE}"
fi
while [[ $# -gt 0 ]]; do
  case $1 in
    -h | --help ) echo "${HELP_MESSAGE}"; exit 1;;
    -d | --dir ) shift; WORKING_DIRECTORY="$(realpath "${1}")";;
    -l | --list ) LIST_STREAMS=1;;
    -e | --ext ) shift; LIST_STREAMS_EXTENSION=$1;;
    --grep ) shift; GREP_STRING="${1}";;
    -* ) echo "Unknown option $1";exit 1;;
    * ) echo "ERR: doesnt look like a valid option";exit 1;;
  esac
  shift
done

function list_streams(){
    local extention="${1}"
    local working_directory="${2}"
    for video1 in "${working_directory}"/*."${extention}"
    do
        echo "$video1"
        ffprobe -show_entries stream=index,codec_type:stream_tags=language -of compact "$video1" 2>&1 | { while read line; do if $(echo "$line" | grep -q -i "stream #"); then echo "$line"; fi; done; while read -d $'\x0D' line; do if $(echo "$line" | grep -q "time="); then echo "$line" | awk '{ printf "%s\r", $8 }'; fi; done; }
    done
}

if [ "${LIST_STREAMS}" -eq 1 ]; then
    list_streams "$LIST_STREAMS_EXTENSION" "${WORKING_DIRECTORY}"
fi