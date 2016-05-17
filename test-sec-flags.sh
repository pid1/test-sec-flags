#!/bin/sh

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

echo -e "Compiling with -fstack-check" 
sed -i '/^CFLAGS = -Wall -pedantic/ s/$/ -fstack-check' Makefile
