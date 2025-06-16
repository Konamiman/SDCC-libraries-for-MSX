        ; Standard putchar routine for MSX-DOS applications - by Konamiman
        ;
        ; Assemble with either sdasz80 or Nestor80 (v1.3.4 or newer):
        ; sdasz80 -o putchar_msxdos.rel putchar_msxdos.asm
        ; N80 putchar_msxdos.asm putchar_msxdos.rel --discard-hash-prefix
        
        .area   _CODE

        ; void putchar(int)

_putchar::
        ld e,l
	ld c,#2 ;MSX-DOS function call _CONOUT
	jp 5
