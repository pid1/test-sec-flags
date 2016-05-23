test-sec-flags
=====

``test-sec-flags`` is a small script intended to automate testing of the
performance impact of various security-oriented compilation flags. The goal is
to determine if the performance impact is small enough to allow for using these
flags as the default compilation flags for Arch Linux packages.

Requirements
------------

- git
- coreutils

For the unixbench and xz tests (easiest):

- gcc

For plotting with plot.py:

- python
- matplotlib
- numpy

Usage
-----

1. Download: ``git clone https://github.com/pid1/test-sec-flags.git --recursive``
2. cd into the project directory: ``cd test-sec-flags``
3. Run the script: ``./test-<foo>``

Run a specific test case:

- pass the test case number to the script: ``./test-<foo> 8``

Makefile overlay:

- invoke all tests of all suites: ``make``
- invole all test cases of a suite: ``make test-unixbench``
- invole specific test cases of a suite: ``make test-unixbench-5``

All of the results will be output to test1.txt, test2.txt, and so on inside of a directory. This will be organized and made easier soon. Summary results for other users can be viewed at https://github.com/pid1/test-sec-flags/wiki.

To plot your results, compile the system summaries as per the formats in ``datasets/<user>[_<device].txt`` and run ``python plot.py <results file>``.
