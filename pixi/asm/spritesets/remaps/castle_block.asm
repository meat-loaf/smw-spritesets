includefrom "remap.asm"

org $038EB0|!bank
	db $00,$02,$04,$06

org $038ECF|!bank
	JSR.w store_tile1_bank3
