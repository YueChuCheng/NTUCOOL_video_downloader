#!/bin/bash
max=200
token=nlCu0nNcZBpLXjOIjGOTKA
expires=168715839065610800
output_file_name=output
request_url="https://files-1.dlc.ntu.edu.tw/cool-video/202205/c13a24e7-0a96-483c-b7a5-612de18f3fe2"

wget -O audio_init.mp4 "$request_url"/audio-1080-init.m4s.mp4?token="$token"&expires="$expires"
wget -O video_init.mp4 "$request_url"/video-1080-init.m4s.mp4?token="$token"&expires="$expires"
wait
for i in `seq 0 $max`
do
    wget "$request_url"/video-1080-"$i".m4s?token="$token"&expires="$expires"

    wget "$request_url"/audio-1080-"$i".m4s?token="$token"&expires="$expires"

done
wait
for i in `seq 0 $max`
do
    cat ./video-1080-"$i".m4s?token="$token"  >> ./video_init.mp4
    cat ./audio-1080-"$i".m4s?token="$token"  >> ./audio_init.mp4
done 
wait
ffmpeg \
    -i ./video_init.mp4 -i ./audio_init.mp4 \
    -c:v copy \
    -map 0:v -map 1:a \
    -y "$output_file_name".mp4
wait
rm ./video*
rm ./audio*


