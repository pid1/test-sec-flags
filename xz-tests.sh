#!/bin/bash

set -e

basedir=`pwd`
results="$basedir/xz-results.txt"

xzurl='http://tukaani.org/xz/xz-5.2.2.tar.gz'
xzfile='xz-5.2.2.tar.gz'
localdir='xz-5.2.2'
JOBS=$(nproc||echo 1)

if [ ! -f "$xzfile" ]
    then
        echo -e "Downloading xz source files..."
        curl -O "$xzurl"
    else
        echo -e "xz already downloaded. Continuing..."
fi

if [ ! -d "$localdir" ]
    then
        tar -xzvf "$xzfile"
    else
        echo -e "xz already extracted. Continuing..."
fi

cd "$localdir"

# download something to compress
if [ ! -f 'linux-4.6.tar.xz' ]
    then
        echo -e 'Downloading Linux source files...'
        curl -O 'https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.6.tar.xz'
        echo -e "Downloading Linux source files..."
    else
        echo -e "Linux already downloaded. Continuing..."
fi

if [ ! -f 'linux-4.6.tar' ]
    then
        echo -e 'Decompressing the Linux source...'
        xz --decompress -k 'linux-4.6.tar.xz'
    else
        echo -e "Source files already decompressed. Continuing..."
fi


if [ -z "$1" ] || [ "1" == "$1" ]; then
	echo -e 'Compiling with -fstack-protector-strong and partial relro'
	LDFLAGS='-Wl,-O1,--sort-common,--as-needed,-z,relro' \
		CFLAGS='-fstack-protector-strong -O2 -pipe' \
		CPPFLAGS='-D_FORTIFY_SOURCE=2' ./configure --disable-rpath --prefix=/usr
	make clean
	make -j${JOBS}
	echo -e "Compilation finished, running test 1"
	bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results 
	bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
	echo -e "Test 1 completed."
fi


if [ -z "$1" ] || [ "2" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, partial relro, and -fstack-check"
	make clean
	LDFLAGS='-Wl,-O1,--sort-common,--as-needed,-z,relro' \
		CFLAGS='-fstack-protector-strong -O2 -pipe -fstack-check' \
		CPPFLAGS='-D_FORTIFY_SOURCE=2' ./configure --disable-rpath --prefix=/usr
	make -j${JOBS}
	echo -e "Compilation finished, running test 2"
	bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
	bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
	echo -e "Test 2 completed."
fi


if [ -z "$1" ] || [ "3" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, partial relro, and PIE"
	LDFLAGS='-Wl,-O1,--sort-common,--as-needed,-z,relro' \
		CFLAGS='-fstack-protector-strong -O2 -pipe -pie -fPIE' \
		CPPFLAGS='-D_FORTIFY_SOURCE=2' ./configure --disable-rpath --prefix=/usr
	make clean
	make -j${JOBS}
	echo -e "Compilation finished, running test 3"
	bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
	bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
	echo -e "Test 3 completed."
fi


if [ -z "$1" ] || [ "4" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, partial relro, PIE, and -fstack-check"
	LDFLAGS='-Wl,-O1,--sort-common,--as-needed,-z,relro -pie' \
		CFLAGS='-fstack-protector-strong -O2 -pipe -fstack-check -fPIE' \
		CPPFLAGS='-D_FORTIFY_SOURCE=2' ./configure --disable-rpath --prefix=/usr
	make clean
	make -j${JOBS}
	echo -e "Compilation finished, running test 4"
	bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
	bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
	echo -e "Test 4 completed."
fi


if [ -z "$1" ] || [ "5" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, full relro, PIE"
	LDFLAGS='-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now -pie' \
		CFLAGS='-fstack-protector-strong -O2 -pipe -fPIE' \
		CPPFLAGS='-D_FORTIFY_SOURCE=2' ./configure --disable-rpath --prefix=/usr
	make clean
	make -j${JOBS}
	echo -e "Compilation finished, running test 5"
	bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
	bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
	echo -e "Test 5 completed."
fi


if [ -z "$1" ] || [ "6" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fstack-check"
	LDFLAGS='-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now -pie' \
		CFLAGS='-fstack-protector-strong -O2 -pipe -fPIE -fstack-check' \
		CPPFLAGS='-D_FORTIFY_SOURCE=2' ./configure --disable-rpath --prefix=/usr
	make clean
	make -j${JOBS}
	echo -e "Compilation finished, running test 6"
	bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
	bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
	echo -e "Test 6 completed."
fi


if [ -z "$1" ] || [ "7" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fno-plt"
	LDFLAGS='-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now -pie' \
		CFLAGS='-fstack-protector-strong -O2 -pipe -fPIE -fno-plt' \
		CPPFLAGS='-D_FORTIFY_SOURCE=2' ./configure --disable-rpath --prefix=/usr
	make clean
	make -j${JOBS}
	echo -e "Compilation finished, running test 7"
	bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
	bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
	echo -e "Test 7 completed."
fi


if [ -z "$1" ] || [ "8" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fno-plt, and -fstack-check"
	LDFLAGS='-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now -pie' \
		CFLAGS='-fstack-protector-strong -O2 -pipe -fPIE -fno-plt -fstack-check' \
		CPPFLAGS='-D_FORTIFY_SOURCE=2' ./configure --disable-rpath --prefix=/usr
	make clean
	make -j${JOBS}
	echo -e "Compilation finished, running test 8"
	bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
	bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
	echo -e "Test 8 completed."
fi
