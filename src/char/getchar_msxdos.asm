	.area _CODE
_getchar::
	ld		c,#8 ;_INNOE
	call	5
	ld d,#0
	ld e,a
	ret
