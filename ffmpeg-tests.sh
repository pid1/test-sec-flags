#!/bin/bash

set -e

ffmpegurl='http://ffmpeg.org/releases/ffmpeg-3.0.2.tar.bz2'
ffmpegfile='ffmpeg-3.0.2.tar.bz2'
localdir='ffmpeg-3.0.2'
JOBS=$(nproc||echo 1)

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

if [ -z "$1" ] || [ "1" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong and partial relro"
	make clean
	LDFLAGS='-Wl,-z,relro' CFLAGS='-fstack-protector-strong -D_FORTIFY_SOURCE=2' make -j${JOBS}
	# result destination folders are hardcoded in Run. We should sed in new paths
	# instead of doing this nonsense
	echo -e "Compilation finished, running test 1"
	./ffmpeg -benchmark -i input.mkv -f null - |& tee test1.txt
	echo -e "Test 1 completed."
fi


if [ -z "$1" ] || [ "2" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, partial relro, and -fstack-check"
	make clean
	LDFLAGS='-Wl,-z,relro' CFLAGS='-fstack-protector-strong -D_FORTIFY_SOURCE=2 -fstack-check' make -j${JOBS}
	echo -e "Compilation finished, running test 2"
	./ffmpeg -benchmark -i input.mkv -f null - |& tee test2.txt
	echo -e "Test 2 completed."
fi


if [ -z "$1" ] || [ "3" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, partial relro, and PIE"
	make clean
	LDFLAGS='-Wl,-z,relro -pie' CFLAGS='-fstack-protector-strong -D_FORTIFY_SOURCE=2 -fPIE' make -j${JOBS}
	echo -e "Compilation finished, running test 3"
	./ffmpeg -benchmark -i input.mkv -f null - |& tee test3.txt
	echo -e "Test 3 completed."
fi


if [ -z "$1" ] || [ "4" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, partial relro, PIE, and -fstack-check"
	make clean
	LDFLAGS='-Wl,-z,relro -pie' CFLAGS='-fstack-protector-strong -D_FORTIFY_SOURCE=2 -fstack-check -fPIE' make -j${JOBS}
	echo -e "Compilation finished, running test 4"
	./ffmpeg -benchmark -i input.mkv -f null - |& tee test4.txt
	echo -e "Test 4 completed."
fi


if [ -z "$1" ] || [ "5" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, full relro, PIE"
	make clean
	LDFLAGS='-Wl,-z,relro,-z,now -pie' CFLAGS='-fstack-protector-strong -D_FORTIFY_SOURCE=2 -fPIE' make -j${JOBS}
	echo -e "Compilation finished, running test 5"
	./ffmpeg -benchmark -i input.mkv -f null - |& tee test5.txt
	echo -e "Test 5 completed."
fi


if [ -z "$1" ] || [ "6" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fstack-check"
	make clean
	LDFLAGS='-Wl,-z,relro,-z,now -pie' CFLAGS='-fstack-protector-strong -D_FORTIFY_SOURCE=2 -fPIE -fstack-check' make -j${JOBS}
	echo -e "Compilation finished, running test 6"
	./ffmpeg -benchmark -i input.mkv -f null - |& tee test6.txt
	echo -e "Test 6 completed."
fi


if [ -z "$1" ] || [ "7" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fno-plt"
	make clean
	LDFLAGS='-Wl,-z,relro,-z,now -pie' CFLAGS='-fstack-protector-strong -D_FORTIFY_SOURCE=2 -fPIE -fno-plt' make -j${JOBS}
	echo -e "Compilation finished, running test 7"
	./ffmpeg -benchmark -i input.mkv -f null - |& tee test7.txt
	echo -e "Test 7 completed."
fi


if [ -z "$1" ] || [ "8" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fno-plt, and -fstack-check"
	make clean
	LDFLAGS='-Wl,-z,relro,-z,now -pie' CFLAGS='-fstack-protector-strong -D_FORTIFY_SOURCE=2 -fPIE -fno-plt -fstack-check' make -j${JOBS}
	echo -e "Compilation finished, running test 8"
	./ffmpeg -benchmark -i input.mkv -f null - |& tee test8.txt
	echo -e "Test 8 completed."
fi
