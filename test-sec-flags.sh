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

echo -e "Compiling with -fstack-protector-strong and partial relro" 
sed -i '/^CFLAGS = -Wall -pedantic/c\CFLAGS = -z,relro -Wall -pedantic $(OPTON) -I $(SRCDIR) -DTIME -fstack-protector-strong -D_FORTIFY_SOURCE=2' Makefile
make || exit
# result destination folders are hardcoded in Run. We should sed in new paths 
# instead of doing this nonsense
echo -e "Compilation finished, running test 1"
bash -c './Run' &> testresults-fstack-relropartial.txt
echo -e "Test 1 completed."
make clean

echo -e "Compiling with -fstack-protector-strong, partial relro, and -fstack-check"
sed -i '/^CFLAGS = -z,relro/c\CFLAGS = -z,relro -Wall -pedantic $(OPTON) -I $(SRCDIR) -DTIME -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fstack-check' Makefile
make || exit
echo -e "Compilation finished, running test 2"
bash -c './Run' &> testresults-fstack-relropartial-fstackcheck.txt
echo -e "Test 2 completed."
make clean
