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


echo -e 'Compiling with -fstack-protector-strong and partial relro'
make clean
CFLAGS='-Wl,-z,relro -fstack-protector-strong -D_FORTIFY_SOURCE=2' make
# result destination folders are hardcoded in Run. We should sed in new paths
# instead of doing this nonsense
echo -e "Compilation finished, running test 1"
bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results 
bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
echo -e "Test 1 completed."


echo -e "Compiling with -fstack-protector-strong, partial relro, and -fstack-check"
make clean
CFLAGS='-Wl,-z,relro -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fstack-check' make
echo -e "Compilation finished, running test 2"
bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
echo -e "Test 2 completed."


echo -e "Compiling with -fstack-protector-strong, partial relro, and PIE"
make clean
CFLAGS='-Wl,-z,relro -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE' make
echo -e "Compilation finished, running test 3"
bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
echo -e "Test 3 completed."


echo -e "Compiling with -fstack-protector-strong, partial relro, PIE, and -fstack-check"
make clean
CFLAGS='-Wl,-z,relro -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fstack-check -pie -fPIE' make
echo -e "Compilation finished, running test 4"
bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $reesults
echo -e "Test 4 completed."


echo -e "Compiling with -fstack-protector-strong, full relro, PIE"
make clean
LDFLAGS='-Wl,-z,now'
CFLAGS='-Wl,-z,relro -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE' make
echo -e "Compilation finished, running test 5"
bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
echo -e "Test 5 completed."


echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fstack-check"
make clean
LDFLAGS='-Wl,-z,now'
CFLAGS='-Wl,-z,relro -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE -fstack-check' make
echo -e "Compilation finished, running test 6"
bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
echo -e "Test 6 completed."


echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fno-plt"
make clean
LDFLAGS='-Wl,-z,now'
CFLAGS='-Wl,-z,relro -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE -fno-plt' make
echo -e "Compilation finished, running test 7"
bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
echo -e "Test 7 completed."


echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fno-plt, and -fstack-check"
make clean
LDFLAGS='-Wl,-z,now'
CFLAGS='-Wl,-z,relro -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE -fno-plt -fstack-check' make
echo -e "Compilation finished, running test 8"
bash -c 'time src/xz/xz --compress --stdout linux-4.6.tar > /dev/null' |& tee -a $results
bash -c 'time src/xz/xz --decompress --stdout linux-4.6.tar.xz > /dev/null' |& tee -a $results
echo -e "Test 8 completed."
