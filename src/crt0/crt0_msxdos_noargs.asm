	; Header file for MSX-DOS programs - by Konamiman & Avelino
	;
	; This is a simplified header that doesn't accept command line arguments
	; or a return value, so programs using it must have "void main()"
	; as the signature for the main method.
	;
	; This source can be assembled with either sdasz80 or Nestor80 (v1.3.4 or newer).
	; Assemble with either of:
	; sdasz80 -o crt0_msxdos_noargs.rel crt0_msxdos_noargs.s
	; N80 crt0_msxdos_noargs.asm crt0_msxdos_noargs.rel --build-type sdcc --accept-dot-prefix --discard-hash-prefix
	;
	; Compilation command line for programs using this header:
	; sdcc -mz80 --no-std-crt0 --code-loc 0x108 --data-loc X crt0_msxdos_noargs.rel <other .rel files> <program source file>
	; X=0  -> global variables will be placed immediately after code
	; X!=0 -> global variables will be placed at address X

	.globl	_main

    .globl  l__INITIALIZER
    .globl  s__INITIALIZED
    .globl  s__INITIALIZER

	.area _HEADER (ABS)

	.org    0x0100  ;MSX-DOS .COM programs start address

	;--- Initialize globals and jump to "main"

init:   call gsinit
	jp   __pre_main

	;--- Program code and data (global vars) start here

	;* Place data after program code, and data init code after data

	.area	_CODE

__pre_main:
	push de
	ld de,#_HEAP_start
	ld (_heap_top),de
	pop de
	jp _main

	.area	_HOME
	.area	_DATA
_heap_top::
	.dw 0

	.area	_INITIALIZED

	.area	_HEAP
_HEAP_start::

	.area	_INITIALIZER
	.area	_GSINIT
gsinit::
	ld	bc,#l__INITIALIZER
	ld	a,b
	or	a,c
	jp	z,gsinext
	ld	de,#s__INITIALIZED
	ld	hl,#s__INITIALIZER
	ldir
gsinext:
	.area	_GSFINAL
	ret

	;--- One-use code area (reusable code memory for heap)
	;* Be aware about heap usage by this code area functions
	;* Use _HEAP_disposable instead in this code area
	.area	_DISPOSABLE

	.area _HEAP_DISP
_HEAP_disposable::

	;* These doesn't seem to be necessary... (?)
	;.area	_OVERLAY
	;.area	_BSS

