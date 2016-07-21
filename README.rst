test-sec-flags
==============

``test-sec-flags`` is a small collection of scripts intended to automate testing the
performance impact of various security-oriented compilation and linking flags. The goal
is to determine if the performance impact is small enough to allow for using these
flags as the default flags for all Arch Linux packages.

Requirements
------------

- git
- coreutils

For the xz and unixbench test suites:

- gcc ``Please take a look at the usage section``

For ffmpeg:

- See `the ffmpeg PKGBUILD`_

.. _the ffmpeg PKGBUILD: https://git.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/ffmpeg

For plotting:

- python
- matplotlib
- numpy

Usage
-----

Make sure that your $PATH does not contain any gcc wrappers like ccache or colorgcc
before executing the test suites, as it may result in problems like unbounded loops.
We highly recommend to use this test suite inside a clean chroot or a clean virtual
machine image to avoid interfering setups.

1. Download: ``git clone https://github.com/pid1/test-sec-flags.git --recursive``
2. cd into the project directory: ``cd test-sec-flags``
3. Setup everything that is needed: ``make setup``
4. Run the script: ``./test-<foo>``

Run a specific test case:

- Pass the test case number to the script: ``./test-<foo> 8``

Makefile overlay:

- Invoke all tests of all suites: ``make``
- Invoke all test cases of a suite: ``make test-unixbench``
- Invoke specific test cases of a suite: ``make test-unixbench-5``

Raw results from each test are output to ``results`` in a timestamped file. Summary results for other users can be viewed at https://github.com/pid1/test-sec-flags/wiki. Please add your results to the wiki as well, preferably maintaining the same format as the results already there.

To plot your results, compile the system summaries as per the formats in ``datasets/<user>[_<device].txt`` and run ``python plot.py <results file>``.

Expected Runtimes
-----------------

Unixbench: ~30-45 minutes per test, 4-6 hours (1 / ~8 hours on atom n450)

xz: On an i5-4440@3.1GHz, ~5 minutes per run, 40 minutes total (~22' / 3 hours on atom n450)

ffmpeg: On an i5-4440@3.1GHz, ~3 minutes per run, 20 minutes total (~1 / 8 hours on atom n450)
