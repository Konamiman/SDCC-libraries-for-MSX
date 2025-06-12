        ; void putchar(int)
        ; Version for MSX BASIC applications

        .area   _CODE

_putchar::
        ld e,l
_putchar_e::
	ld	a,e
	jp	0x00A2
