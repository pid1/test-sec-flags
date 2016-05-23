#!/bin/bash

set -e

basedir=`pwd`
results="$basedir/xz-results.txt"

xzurl='http://tukaani.org/xz/xz-5.2.2.tar.gz'
xzfile='xz-5.2.2.tar.gz'
localdir='xz-5.2.2'

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
echo -e "running ./configure"
./configure

sed 's/^CFLAGS = -g -O2/CFLAGS += -g -O2/g' -i Makefile

sed 's/^LDFLAGS =/LDFLAGS += /g' -i Makefile


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
	make clean
	LDFLAGS='-Wl,-z,relro' CFLAGS='-fstack-protector-strong -D_FORTIFY_SOURCE=2' make
	echo -e "Compilation finished, running test 1"
	bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results 
	bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
	echo -e "Test 1 completed."
fi


if [ -z "$1" ] || [ "2" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, partial relro, and -fstack-check"
	make clean
	LDFLAGS='-Wl,-z,relro' CFLAGS='-fstack-protector-strong -D_FORTIFY_SOURCE=2 -fstack-check' make
	echo -e "Compilation finished, running test 2"
	bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
	bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
	echo -e "Test 2 completed."
fi


if [ -z "$1" ] || [ "3" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, partial relro, and PIE"
	make clean
	LDFLAGS='-Wl,-z,relro' CFLAGS='-fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE' make
	echo -e "Compilation finished, running test 3"
	bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
	bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
	echo -e "Test 3 completed."
fi


if [ -z "$1" ] || [ "4" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, partial relro, PIE, and -fstack-check"
	make clean
	LDFLAGS='-Wl,-z,relro -pie' CFLAGS='-fstack-protector-strong -D_FORTIFY_SOURCE=2 -fstack-check -fPIE' make
	echo -e "Compilation finished, running test 4"
	bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
	bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $reesults
	echo -e "Test 4 completed."
fi


if [ -z "$1" ] || [ "5" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, full relro, PIE"
	make clean
	LDFLAGS='-Wl,-z,relro,-z,now -pie' CFLAGS='-fstack-protector-strong -D_FORTIFY_SOURCE=2 -fPIE' make
	echo -e "Compilation finished, running test 5"
	bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
	bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
	echo -e "Test 5 completed."
fi


if [ -z "$1" ] || [ "6" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fstack-check"
	make clean
	LDFLAGS='-Wl,-z,relro,-z,now -pie' CFLAGS='-fstack-protector-strong -D_FORTIFY_SOURCE=2 -fPIE -fstack-check' make
	echo -e "Compilation finished, running test 6"
	bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
	bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
	echo -e "Test 6 completed."
fi


if [ -z "$1" ] || [ "7" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fno-plt"
	make clean
	LDFLAGS='-Wl,-z,relro,-z,now -pie' CFLAGS='-fstack-protector-strong -D_FORTIFY_SOURCE=2 -fPIE -fno-plt' make
	echo -e "Compilation finished, running test 7"
	bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
	bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
	echo -e "Test 7 completed."
fi


if [ -z "$1" ] || [ "8" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fno-plt, and -fstack-check"
	make clean
	LDFLAGS='-Wl,-z,relro,-z,now -pie' CFLAGS='-fstack-protector-strong -D_FORTIFY_SOURCE=2 -fPIE -fno-plt -fstack-check' make
	echo -e "Compilation finished, running test 8"
	bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
	bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
	echo -e "Test 8 completed."
fi
