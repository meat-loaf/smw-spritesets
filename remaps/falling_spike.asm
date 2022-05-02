includefrom "remaps.asm"

org $03921C|!bank
	db $0E
org $03921D|!bank
	JSR.w store_tile1_bank3
