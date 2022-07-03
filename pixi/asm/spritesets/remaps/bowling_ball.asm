includefrom "remaps.asm"

org $03B1ED|!bank
	db $00,$02,$00,$04
	db $05,$04,$00,$02
	db $00,$19,$09,$07

org $03B241|!bank
	JSR.w store_tile1_bank3
