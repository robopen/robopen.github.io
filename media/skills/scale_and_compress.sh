#!/bin/bash

fs=`find . -type f | grep mp4 | grep -v 720w`
# fs=`ls -a | egrep '\.mp4$|\.mp3$|\.exe$'`
cropdir="./crop_720w/"
mkdir -p ${cropdir}
for f in ${fs[@]}
do
  echo "f is", "$f"
  newf=${f%.*}"_720w.mp4"
  finalf=${f%.*}"_720w_compress.mp4"
  echo "new file ", $newf
  # ffmpeg -i $f -filter:v scale=720:-1 -c:a copy ${cropdir}${newf}
  ffmpeg -i $f -filter:v scale=-2:540 -c:a copy ${cropdir}${newf}
  ffmpeg -i ${cropdir}${newf}  -vcodec libx264 -crf 28 ${cropdir}${finalf}
  echo "Did crop and compress, ./crop_720w/"${newf}

done
