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

echo -e "Compiling with -fstack-protector-string and partial relro" 
sed -i '/^CFLAGS = -Wall -pedantic/c\CFLAGS = -z,relro -Wall -pedantic $(OPTON) -I $(SRCDIR) -DTIME -fstack-protector-strong -D_FORTIFY_SOURCE=2' Makefile
make || exit
./Run |& testresults-fstack-relropartial.txt
make clean

