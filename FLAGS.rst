Flags
=====

Defaults
--------
makepkg.conf already defines the following:

- CPPFLAGS= -D_FORTIFY_SOURCE=2
- CFLAGS= -fstack-protector-strong
- CXXFLAGS= -fstack-protector-strong
- LDFLAGS= -z,relro

Proposed
--------
- -fstack-protector-strong and partial relro + PIE
- -fstack-protector-strong and PIE + full RELRO
- -fstack-protector-strong and PIE + full RELRO + no-plt
