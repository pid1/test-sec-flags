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
