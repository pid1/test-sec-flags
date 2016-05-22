#!/bin/bash

set -e

ffmpegurl='http://ffmpeg.org/releases/ffmpeg-3.0.2.tar.bz2'
ffmpegfile='ffmpeg-3.0.2.tar.bz2'
localdir='ffmpeg-3.0.2'

if [ ! -f "$ffmpegfile" ]
    then
        echo -e "Downloading ffmpeg source files..."
        curl -O "$ffmpegurl"
    else
        echo -e "ffmpeg already downloaded. Continuing..."
fi

if [ ! -d "$localdir" ]
    then
        tar -xvf "$ffmpegfile"
    else
        echo -e "ffmpeg alreday extracted. Continuing..."
fi

cd "$localdir"
