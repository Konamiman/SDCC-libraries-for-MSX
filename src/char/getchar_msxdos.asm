        ; Standard getchar routine for MSX-DOS applications - by Konamiman
        ;
        ; Assemble with either sdasz80 or Nestor80 (v1.3.4 or newer):
        ; sdasz80 -o getchar_msxdos.rel getchar_msxdos.asm
        ; N80 getchar_msxdos.asm getchar_msxdos.rel

	.area _CODE

_getchar::
	ld c,#8 ;MSX-DOS function call _INNOE
	call 5
	ld d,#0
	ld e,a
	ret
