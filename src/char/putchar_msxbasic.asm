        ; Standard putchar routine for MSX-BASIC applications - by Konamiman
        ;
        ; Assemble with either sdasz80 or Nestor80 (v1.3.4 or newer):
        ; sdasz80 -o putchar_msxbasic.rel putchar_msxbasic.asm
        ; N80 putchar_msxbasic.asm putchar_msxbasic.rel

        .area   _CODE

        ; void putchar(int)

_putchar::
	ld	a,l
	jp	0x00A2  ;MSX BIOS routine CHPUT
