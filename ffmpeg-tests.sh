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
echo -e "running ./configure"

./configure \
    --prefix='/usr' \
    --disable-debug \
    --disable-static \
    --disable-stripping \
    --enable-avisynth \
    --enable-avresample \
    --enable-fontconfig \
    --enable-gnutls \
    --enable-gpl \
    --enable-ladspa \
    --enable-libass \
    --enable-libbluray \
    --enable-libdcadec \
    --enable-libfreetype \
    --enable-libfribidi \
    --enable-libgsm \
    --enable-libiec61883 \
    --enable-libmodplug \
    --enable-libmp3lame \
    --enable-libopencore_amrnb \
    --enable-libopencore_amrwb \
    --enable-libopenjpeg \
    --enable-libopus \
    --enable-libpulse \
    --enable-libschroedinger \
    --enable-libsoxr \
    --enable-libspeex \
    --enable-libssh \
    --enable-libtheora \
    --enable-libv4l2 \
    --enable-libvidstab \
    --enable-libvorbis \
    --enable-libvpx \
    --enable-libwebp \
    --enable-libx264 \
    --enable-libx265 \
    --enable-libxvid \
    --enable-netcdf \
    --enable-shared \
    --enable-version3 \
    --enable-x11grab

echo -e "Compiling with -fstack-protector-strong and partial relro"
make clean
CFLAGS='-Wl,-z,relro -fstack-protector-strong -D_FORTIFY_SOURCE=2' make
# result destination folders are hardcoded in Run. We should sed in new paths
# instead of doing this nonsense
echo -e "Compilation finished, running test 1"
./ffmpeg -benchmark -i input.mkv -f null - |& tee test1.txt
echo -e "Test 1 completed."


echo -e "Compiling with -fstack-protector-strong, partial relro, and -fstack-check"
make clean
CFLAGS='-Wl,-z,relro -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fstack-check' make
echo -e "Compilation finished, running test 2"
./ffmpeg -benchmark -i input.mkv -f null - |& tee test2.txt
echo -e "Test 2 completed."


echo -e "Compiling with -fstack-protector-strong, partial relro, and PIE"
make clean
CFLAGS='-Wl,-z,relro -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE' make
echo -e "Compilation finished, running test 3"
./ffmpeg -benchmark -i input.mkv -f null - |& tee test3.txt
echo -e "Test 3 completed."


echo -e "Compiling with -fstack-protector-strong, partial relro, PIE, and -fstack-check"
make clean
CFLAGS='-Wl,-z,relro -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fstack-check -pie -fPIE' make
echo -e "Compilation finished, running test 4"
./ffmpeg -benchmark -i input.mkv -f null - |& tee test4.txt
echo -e "Test 4 completed."


echo -e "Compiling with -fstack-protector-strong, full relro, PIE"
make clean
CFLAGS='-Wl,-z,relro,-z,now -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE' make
echo -e "Compilation finished, running test 5"
./ffmpeg -benchmark -i input.mkv -f null - |& tee test5.txt
echo -e "Test 5 completed."


echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fstack-check"
make clean
CFLAGS='-Wl,-z,relro,-z,now -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE -fstack-check' make
echo -e "Compilation finished, running test 6"
./ffmpeg -benchmark -i input.mkv -f null - |& tee test6.txt
echo -e "Test 6 completed."


echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fno-plt"
make clean
CFLAGS='-Wl,-z,relro,-z,now -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE -fno-plt' make
echo -e "Compilation finished, running test 7"
./ffmpeg -benchmark -i input.mkv -f null - |& tee test7.txt
echo -e "Test 7 completed."


echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fno-plt, and -fstack-check"
make clean
CFLAGS='-Wl,-z,relro,-z,now -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE -fno-plt -fstack-check' make
echo -e "Compilation finished, running test 8"
./ffmpeg -benchmark -i input.mkv -f null - |& tee test8.txt
echo -e "Test 8 completed."
