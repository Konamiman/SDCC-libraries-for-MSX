
	; Header file for MSX-DOS programs - by Konamiman & Avelino
	;
	; This is a full header that handles command line arguments
        ; and accepts a return value for the OS (the later works in MSX-DOS 2 only),
	; so programs using it must have the standard "int main(char *argv, int argc)"
	; as the signature for the main method.
	;
	; This source can be assembled with either sdasz80 or Nestor80 (v1.3.4 or newer).
	; Assemble with either of:
	; sdasz80 -o crt0_msxdos.rel crt0_msxdos.s
	; N80 crt0_msxdos.asm crt0_msxdos.rel --build-type sdcc --accept-dot-prefix --discard-hash-prefix
	;
	; Compilation command line for programs using this header:
	; sdcc -mz80 --no-std-crt0 --code-loc 0x180 --data-loc X crt0_msxdos_noargs.rel <other .rel files> <program source file>
	; X=0  -> global variables will be placed immediately after code
	; X!=0 -> global variables will be placed at address X

	.globl	_main

    .globl  l__INITIALIZER
    .globl  s__INITIALIZED
    .globl  s__INITIALIZER

	.area _HEADER (ABS)

        .org    0x0100  ;MSX-DOS .COM programs start address

        ;--- Step 1: Initialize globals

init:   call    gsinit

        ;--- Step 2: Build the parameter pointers table on 0x100,
        ;    and terminate each parameter with 0.
        ;    MSX-DOS places the command line length at 0x80 (one byte),
        ;    and the command line itself at 0x81 (up to 127 characters).

        ;* Check if there are any parameters at all

        ld      a,(#0x80)
        or      a
        ld      c,#0
        jr      z,cont
        
        ;* Terminate command line with 0
        ;  (DOS 2 does this automatically but DOS 1 does not)
        
        ld      hl,#0x81
        ld      bc,(#0x80)
        ld      b,#0
        add     hl,bc
        ld      (hl),#0
        
        ;* Copy the command line processing code to 0xC000 and
        ;  execute it from there, this way the memory of the original code
        ;  can be recycled for the parameter pointers table.
        ;  (The space from 0x100 up to "cont" can be used,
        ;   this is room for about 40 parameters.
        ;   No real world application will handle so many parameters.)
        
        ld      hl,#parloop
        ld      de,#0xC000
        ld      bc,#parloopend-#parloop
        ldir
        
        ;* Initialize registers and jump to the loop routine
        
        ld      hl,#0x81        ;Command line pointer
        ld      c,#0            ;Number of params found
        ld      ix,#0x100       ;Params table pointer
        
        ld      de,#cont        ;To continue execution at "cont"
        push    de              ;when the routine RETs
        jp      0xC000
        
        ;>>> Command line processing routine begin
        
        ;* Loop over the command line: skip spaces
        
parloop: ld      a,(hl)
        or      a       ;Command line end found?
        ret     z

        cp      #32
        jr      nz,parfnd
        inc     hl
        jr      parloop

        ;* Parameter found: add its address to params table...

parfnd: ld      (ix),l
        ld      1(ix),h
        inc     ix
        inc     ix
        inc     c
        
        ld      a,c     ;protection against too many parameters
        cp      #40
        ret     nc
        
        ;* ...and skip chars until finding a space or command line end
        
parloop2:       ld      a,(hl)
        or      a       ;Command line end found?
        ret     z
        
        cp      #32
        jr      nz,nospc        ;If space found, set it to 0
                                ;(string terminator)...
        ld      (hl),#0
        inc     hl
        jr      parloop         ;...and return to space skipping loop

nospc:  inc     hl
        jr      parloop2

parloopend:
        
        ;>>> Command line processing routine end
        
        ;* Command line processing done. Here, C=number of parameters.

cont:   ld      hl,#0x100 ;char **argv
        ld      d,#0
        ld      e,c     ;int argc

        ;--- Step 3: Call the "main" function

	push de
	ld de,#_HEAP_start
	ld (_heap_top),de
	pop de

	call    _main

        ;--- Step 4: Program termination.
        ;    Termination code for DOS 2 was returned on L.
                
        ld      c,#0x62   ;DOS 2 function for program termination (_TERM)
        ld      b,e
        call    5      ;On DOS 2 this terminates; on DOS 1 this returns...
        ld      c,#0x0
        jp      5      ;...and then this one terminates
                       ;(DOS 1 function for program termination).

        ;--- Program code and data (global vars) start here

	;* Place data after program code, and data init code after data

	.area	_CODE
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
    .area   _GSFINAL
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

