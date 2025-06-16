	; Header for binary MSX programs compiled with SDCC - by Konamiman
	;
	; Programs compiled with this header can be loaded in MSX-BASIC
	; with the BLOAD instruction: BLOAD "filename"[,R]
	;
	; This source needs to be assembled with Nestor80 (v1.3.4 or newer)
	; and accepts the program start address as a command line argument. Assemble with:
	; N80 crt0_msxbasic_n80.asm crt0_msxbasic.rel --build-type sdcc --accept-dot-prefix --discard-hash-prefix --define-symbol START_ADDRESS=xxxxh
	;
	; Compilation command line for programs using this header:
	; sdcc -mz80 --no-std-crt0 --code-loc <start address + 32> --data-loc X crt0_msxbasic.rel <other .rel files> <program source file>
	; X=0  -> global variables will be placed immediately after code
	; X!=0 -> global vars variables be placed at address X
	
	ifndef START_ADDRESS
	.error Missing start address. Pass it to N80 like this: --define-symbol START_ADDRESS=xxxxh
	endif

	.globl	_main

    .globl  l__INITIALIZER
    .globl  s__INITIALIZED
    .globl  s__INITIALIZER

	.area _HEADER (ABS)

	org    START_ADDRESS
    db 	0xFE
    dw 	init
    dw		end
    dw 	init

	;--- Initialize globals and jump to "main"

init:
    ld	bc, l__INITIALIZER
	ld	a, b
	or	a, c
	jp	z,_main
	ld	de, s__INITIALIZED
	ld	hl, s__INITIALIZER
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
