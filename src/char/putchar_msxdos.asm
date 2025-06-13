        ; void putchar(int)
        ; Version for MSX-DOS applications
        ;
        ; Assemble with either sdasz80 or Nestor80 (v1.3.4 or newer):
        ;
        ; sdasz80 -o putchar_msxdos.rel putchar_msxdos.asm
        ; N80 putchar_msxdos.asm putchar_msxdos.rel --discard-hash-prefix
        
        .area   _CODE

_putchar::
        ld e,l
	ld	c,#2 ;_CONOUT
	jp	5
