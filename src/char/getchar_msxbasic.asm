	.area _CODE
_getchar::       
	call 0x009F ;MSX BIOS routine CHGET
	ld e,a
	ld d,#0
	ret

	
