#!/bin/bash

set -e

basedir=`pwd`
results="$basedir/unixbench-results.txt"

if [ ! -f 'unixbench-results.txt' ]
    then
        touch unixbench-results.txt
    else
        echo -e "Unixbench has already been cloned. Continuing..."
fi

unixbenchrepo=https://github.com/kdlucas/byte-unixbench.git
localdir=unixbench

if [ ! -d "$localdir" ]
    then
        echo -e "Cloning unixbench..."
        git clone --depth 1 "$unixbenchrepo" "$localdir"
    else
        echo -e "Unixbench has already been cloned. Continuing..."
fi

cd "$localdir"/UnixBench
JOBS=$(nproc||echo 1)

# reset Makefile and patch CFLAGS to append project-specific flags
git checkout Makefile
sed 's/^CFLAGS =/CFLAGS +=/g' -i Makefile

if [ -z "$1" ] || [ "1" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong and partial relro"
	make clean
	LDFLAGS='-Wl,-O1,--sort-common,--as-needed,-z,relro' \
		CFLAGS='-fstack-protector-strong -D_FORTIFY_SOURCE=2' \
		make -j${JOBS}
	echo -e "Compilation finished, running test 1"
	bash -c './Run' &>> $results
	echo -e "Test 1 completed."
fi


if [ -z "$1" ] || [ "2" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, partial relro, and -fstack-check"
	make clean
	LDFLAGS='-Wl,-O1,--sort-common,--as-needed,-z,relro' \
		CFLAGS='-pipe -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fstack-check' \
		make -j${JOBS}
	echo -e "Compilation finished, running test 2"
	bash -c './Run' &>> $results
	echo -e "Test 2 completed."
fi


if [ -z "$1" ] || [ "3" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, partial relro, and PIE"
	make clean
	LDFLAGS='-Wl,-O1,--sort-common,--as-needed,-z,relro -pie' \
		CFLAGS='-pipe -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fPIE' \
		make -j${JOBS}
	echo -e "Compilation finished, running test 3"
	bash -c './Run' &>> $results
	echo -e "Test 3 completed."
fi


if [ -z "$1" ] || [ "4" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, partial relro, PIE, and -fstack-check"
	make clean
	LDFLAGS='-Wl,-O1,--sort-common,--as-needed,-z,relro -pie' \
		CFLAGS='-pipe -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fstack-check -fPIE' \
		make -j${JOBS}
	echo -e "Compilation finished, running test 4"
	bash -c './Run' &>> $results
	echo -e "Test 4 completed."
fi


if [ -z "$1" ] || [ "5" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, full relro, PIE"
	make clean
	LDFLAGS='-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now -pie' \
		CFLAGS='-pipe -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fPIE' \
		make -j${JOBS}
	echo -e "Compilation finished, running test 5"
	bash -c './Run' &>> $results
	echo -e "Test 5 completed."
fi


if [ -z "$1" ] || [ "6" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fstack-check"
	make clean
	LDFLAGS='-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now -pie' \
		CFLAGS='-pipe -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fPIE -fstack-check' \
		make -j${JOBS}
	echo -e "Compilation finished, running test 6"
	bash -c './Run' &>> $results
	echo -e "Test 6 completed."
fi


if [ -z "$1" ] || [ "7" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fno-plt"
	make clean
	LDFLAGS='-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now -pie' \
		CFLAGS='-pipe -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fPIE -fno-plt' \
		make -j${JOBS}
	echo -e "Compilation finished, running test 7"
	bash -c './Run' &>> $results
	echo -e "Test 7 completed."
fi


if [ -z "$1" ] || [ "8" == "$1" ]; then
	echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fno-plt, and -fstack-check"
	make clean
	LDFLAGS='-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now -pie' \
		CFLAGS='-pipe -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fPIE -fno-plt -fstack-check' \
		make -j${JOBS}
	echo -e "Compilation finished, running test 8"
	bash -c './Run' &>> $results
	echo -e "Test 8 completed."
fi
