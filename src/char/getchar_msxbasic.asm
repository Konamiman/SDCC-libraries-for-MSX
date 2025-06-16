        ; Standard getchar routine for MSX-BASIC applications - by Konamiman
        ;
        ; Assemble with either sdasz80 or Nestor80 (v1.3.4 or newer):
        ; sdasz80 -o getchar_msxbasic.rel getchar_msxbasic.asm
        ; N80 getchar_msxbasic.asm getchar_msxbasic.rel

	.area _CODE

	;int getchar()

_getchar::       
	call 0x009F ;MSX BIOS routine CHGET
	ld e,a
	ld d,#0
	ret
	