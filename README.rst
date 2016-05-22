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
For plotting with plot.py:

- python
- matplotlib
- numpy

Usage
-----

For the Unixbench tests:

1. Download: ``git clone https://github.com/pid1/test-sec-flags.git``
2. cd into the project directory: ``cd test-sec-flags``
3. Set permissions on the script: ``chmod +x unixbench-test.sh``
4. Run the script: ``./unixbench-test.sh``

All of the results will be output to test1.txt, test2.txt, and so on inside of the unixbench/UnixBench directory. Summary results for other users can be viewed at https://github.com/pid1/test-sec-flags/wiki.

To plot your results, compile the system summaries as per the formats in ``datasets/<user>_[<device].txt`` and run ``python plot.py datasets/<foo>.txt`` from the project directory.
