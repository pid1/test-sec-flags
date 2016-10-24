test-sec-flags
==============

``test-sec-flags`` is a small collection of scripts intended to automate testing the
performance impact of various security-oriented compilation and linking flags. The goal
is to determine if the performance impact is small enough to allow for using these
flags as the default flags for all Arch Linux packages.

Current Status
--------------
A huge thank you to everyone who contributed to this effort. As per Allan's post
on the mailing list, we will be implementing these flags in Arch. 
https://lists.archlinux.org/pipermail/arch-dev-public/2016-October/028405.html
Please follow the mailing list for news on future developments.

Requirements
------------

- git
- coreutils

For the xz and unixbench test suites:

- gcc ``Please take a look at the usage section``

For ffmpeg:

- ffmpeg requires all of the deps and makedeps as outlined in `the ffmpeg PKGBUILD`_

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

Issues
------

If you encounter bugs, please open an issue on the bugtracker. Ensure that you have installed all of the necessary dependencies and makedeps, and that you are running this in a clean chroot or virtual machine.

Feature Requests and Enhancements
---------------------------------

Feature requests and suggested enhancements should be added to https://github.com/pid1/test-sec-flags/wiki/Feature-Requests

Expected Runtimes
-----------------

Unixbench: 

On an i5-4440@3.1GHz, about 30-45 minutes per test, 4-6 hours total

On an Atom N450, about 1 hour per test, 8 hours total 

xz: 

On an i5-4440@3.1GHz, about 5 minutes per run, 40 minutes total

On an Atom N450, about 22 minutes per test, 3 hours total

ffmpeg: 

On an i5-4440@3.1GHz, about 3 minutes per run, 20 minutes total

On an Atom N450, about 1 hour per run, 8 hours total
