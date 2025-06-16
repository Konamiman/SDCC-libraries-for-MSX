# SDCC libraries for MSX

This is a collection of miscellaneous libraries intended for using in MSX programs written in C and compiled with [SDCC](https://sdcc.sourceforge.net/).


## What's included

The `src` directory contains:

* `types.h`: some convenient generic type definitions/aliases.

* `asm`: a library to interact with assembler code from within C programs. Includes specialized functions for [UNAPI](https://github.com/Konamiman/MSX-UNAPI-specification) integration.

* `crt0`: header files for MSX-BASIC and MSX-DOS programs, as a replacement for the standard header supplied with SDCC, which is useless for MSX development.

* `char`: implementations of `getchar` and `putchar` for MSX, as well as a simplified `printf` function.

* `base64` and `sha1`: a couple of self-explanatory utility libraries.

As a rule of thumb assembler sources (files with `.asm` extension) can be assembled with either sdasz80 (the assembler that comes bundled with the SDCC install) or [Nestor80](https://github.com/Konamiman/Nestor80) (version 1.3.4 or newer). See the header comment in each source file for more details.

The `examples` directory contains some example programs that make use of the libraries, as well as a makefile that you can use as guidance for your own projects. The makefile 


## How to use

The recommended approach is to create a repository for your project and link this one as [a Git submodule](https://github.blog/open-source/git/working-with-submodules/). See [the UNAPI repository](https://github.com/Konamiman/MSX-UNAPI-specification) for a working example.
