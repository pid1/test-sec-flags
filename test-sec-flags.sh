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
bash -c './Run' &> test1.txt
echo -e "Test 1 completed."
make clean


echo -e "Compiling with -fstack-protector-strong, partial relro, and -fstack-check"
sed -i '/^CFLAGS = -z,relro/c\CFLAGS = -z,relro -Wall -pedantic $(OPTON) -I $(SRCDIR) -DTIME -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fstack-check' Makefile
make || exit
echo -e "Compilation finished, running test 2"
bash -c './Run' &> test2.txt
echo -e "Test 2 completed."
make clean


echo -e "Compiling with -fstack-protector-strong, partial relro, and PIE"
sed -i '/^CFLAGS = -z,relro/c\CFLAGS = -z,relro -Wall -pedantic $(OPTON) -I $(SRCDIR) -DTIME -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fPIE' Makefile
make || exit
echo -e "Compilation finished, running test 3"
bash -c './Run' &> test3.txt
echo -e "Test 3 completed."
make clean


echo -e "Compiling with -fstack-protector-strong, partial relro, PIE, and -fstack-check"
sed -i '/^CFLAGS = -z,relro/c\CFLAGS = -z,relro -Wall -pedantic $(OPTON) -I $(SRCDIR) -DTIME -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fstack-check -pie -fPIE' Makefile
make || exit
echo -e "Compilation finished, running test 2"
bash -c './Run' &> test4.txt
echo -e "Test 4 completed."
make clean


echo -e "Compiling with -fstack-protector-strong, full relro, PIE"
sed -i '/^CFLAGS = -z,relro/c\CFLAGS = -z,relro,-z,now -Wall -pedantic $(OPTON) -I $(SRCDIR) -DTIME -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE' Makefile
make || exit
echo -e "Compilation finished, running test 2"
bash -c './Run' &> test5.txt
echo -e "Test 5 completed."
make clean


echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fstack-check"
sed -i '/^CFLAGS = -z,relro/c\CFLAGS = -z,relro,-z,now -Wall -pedantic $(OPTON) -I $(SRCDIR) -DTIME -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE -fstack-check' Makefile
make || exit
echo -e "Compilation finished, running test 2"
bash -c './Run' &> test6.txt
echo -e "Test 6 completed."
make clean


echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fno-plt"
sed -i '/^CFLAGS = -z,relro/c\CFLAGS = -z,relro,-z,now -Wall -pedantic $(OPTON) -I $(SRCDIR) -DTIME -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE -fno-plt' Makefile
make || exit
echo -e "Compilation finished, running test 2"
bash -c './Run' &> test7.txt
echo -e "Test 7 completed."
make clean


echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fno-plt, and -fstack-check"
sed -i '/^CFLAGS = -z,relro/c\CFLAGS = -z,relro,-z,now -Wall -pedantic $(OPTON) -I $(SRCDIR) -DTIME -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE -fno-plt -fstack-check' Makefile
make || exit
echo -e "Compilation finished, running test 2"
bash -c './Run' &> test8.txt
echo -e "Test 8 completed."
make clean
