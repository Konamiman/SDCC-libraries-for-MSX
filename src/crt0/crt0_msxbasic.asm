	; Header for binary MSX programs compiled with SDCC - by Konamiman
	;
	; Programs compiled with this header can be loaded in MSX-BASIC
	; with the BLOAD instruction: BLOAD "filename"[,R]
	;
	; This source can be assembled with either sdasz80 or Nestor80 (v1.3.4 or newer).
	; You need to set the program start address appropriately for your project
	; (it's the argument to the .org statement).
	; Assemble with either of:
	; sdasz80 -o crt0_msxbasic.rel crt0_msxbasic.s
	; N80 crt0_msxbasic_n80.asm crt0_msxbasic.rel --build-type sdcc --accept-dot-prefix --discard-hash-prefix
	;
	; The crt0_msxbasic_n80.asm variant accepts the start address as a command line argument
	; and can be assembled with Nestor80 only.
	;
	; Compilation command line for programs using this header:
	; sdcc -mz80 --no-std-crt0 --code-loc <start address + 32> --data-loc X crt0_msxbasic.rel <other .rel files> <program source file>
	; X=0  -> global variables will be placed immediately after code
	; X!=0 -> global variables will be placed at address X
	
	.globl	_main

    .globl  l__INITIALIZER
    .globl  s__INITIALIZED
    .globl  s__INITIALIZER

	.area _HEADER (ABS)

	.org    0xA000
    .db 	0xFE
    .dw 	init
    .dw		end
    .dw 	init

	;--- Initialize globals and jump to "main"

init:
    ld	bc, #l__INITIALIZER
	ld	a, b
	or	a, c
	jp	z,_main
	ld	de, #s__INITIALIZED
	ld	hl, #s__INITIALIZER
	ldir

	jp    _main

	;; Ordering of segments for the linker.
	.area	_HOME
	.area	_CODE
	.area	_INITIALIZER
	.area   _GSINIT
	.area   _GSFINAL
	.area	_DATA
	.area	_INITIALIZED
	.area	_BSEG
	.area   _BSS
	.area   _HEAP

end:
