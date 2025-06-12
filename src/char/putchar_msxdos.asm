        ; void putchar(int)
        ; Version for MSX-DOS applications
        
        .area   _CODE

_putchar::
        ld e,l
_putchar_e::
	ld	c,#2
	jp	5
