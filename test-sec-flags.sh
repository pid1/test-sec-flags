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

# reset Makefile and patch CFLAGS to append project specific things
# this makes it lot easier to pass test specific flags
git checkout Makefile
sed 's/^CFLAGS =/CFLAGS +=/g' -i Makefile

echo -e "Compiling with -fstack-protector-strong and partial relro"
make clean
CFLAGS='-z,relro -fstack-protector-strong -D_FORTIFY_SOURCE=2' make || exit
# result destination folders are hardcoded in Run. We should sed in new paths
# instead of doing this nonsense
echo -e "Compilation finished, running test 1"
bash -c './Run' &> test1.txt
echo -e "Test 1 completed."


echo -e "Compiling with -fstack-protector-strong, partial relro, and -fstack-check"
make clean
CFLAGS='-z,relro -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fstack-check' make || exit
echo -e "Compilation finished, running test 2"
bash -c './Run' &> test2.txt
echo -e "Test 2 completed."


echo -e "Compiling with -fstack-protector-strong, partial relro, and PIE"
make clean
CFLAGS='-z,relro -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE' make || exit
echo -e "Compilation finished, running test 3"
bash -c './Run' &> test3.txt
echo -e "Test 3 completed."


echo -e "Compiling with -fstack-protector-strong, partial relro, PIE, and -fstack-check"
make clean
CFLAGS='-z,relro -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fstack-check -pie -fPIE' make || exit
echo -e "Compilation finished, running test 4"
bash -c './Run' &> test4.txt
echo -e "Test 4 completed."


echo -e "Compiling with -fstack-protector-strong, full relro, PIE"
make clean
CFLAGS='-z,relro,-z,now -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE' make || exit
echo -e "Compilation finished, running test 5"
bash -c './Run' &> test5.txt
echo -e "Test 5 completed."


echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fstack-check"
make clean
CFLAGS='-z,relro,-z,now -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE -fstack-check' make || exit
echo -e "Compilation finished, running test 6"
bash -c './Run' &> test6.txt
echo -e "Test 6 completed."


echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fno-plt"
make clean
CFLAGS='-z,relro,-z,now -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE -fno-plt' make || exit
echo -e "Compilation finished, running test 7"
bash -c './Run' &> test7.txt
echo -e "Test 7 completed."


echo -e "Compiling with -fstack-protector-strong, full relro, PIE, -fno-plt, and -fstack-check"
make clean
CFLAGS='-z,relro,-z,now -fstack-protector-strong -D_FORTIFY_SOURCE=2 -pie -fPIE -fno-plt -fstack-check' make || exit
echo -e "Compilation finished, running test 8"
bash -c './Run' &> test8.txt
echo -e "Test 8 completed."
