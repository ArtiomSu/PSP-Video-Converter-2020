#!/bin/bash

youtube-dl --external-downloader aria2c --external-downloader-args '-c -j 16 -x 16 -s 16 -k 1M' -f bestvideo+bestaudio --postprocessor-args '-flags +bitexact -vcodec libx264 -profile:v baseline -level 3.0 -s 480x272 -b:v 2.5m -acodec aac -b:a 192k -ar 48000 -strict -2 -f mp4' --recode-video mp4 "${1}"

ffmpeg -y -hide_banner -loglevel warning -i "$(youtube-dl --get-thumbnail "${1}")" -f image2 -vframes 1 -vf "scale=160:120:force_original_aspect_ratio=decrease,pad=160:120:(ow-iw)/2:(oh-ih)/2" "$(youtube-dl --get-filename "${1}" | rev | cut -d"." -f2- | rev).THM"
