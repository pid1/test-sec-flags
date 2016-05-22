test-sec-flags
=====

``test-sec-flags`` is a small script intended to automate testing of the
performance impact of various security-oriented compilation flags. The goal is
to determine if the performance impact is small enough to allow for using these
flags as the default compilation flags for Arch Linux packages.

Requirements
------------
- gcc
- git

Optional Requirements
---------------------
For plotting with plot.py
- python
- matplotlib
- numpy

Usage
-----
1. Download: ``git clone https://github.com/pid1/test-sec-flags.git``
2. cd into the project directory: ``cd test-sec-flags``
3. Set permissions on the script: ``chmod +x test-sec-flags.sh``
4. Run the script: ``./test-sec-flags.sh``

All of the results will be output to test1.txt, test2.txt, and so on inside of the unixbench/UnixBench directory. Summary results for other users can be viewed at https://github.com/pid1/test-sec-flags/wiki.
