includefrom "remaps.asm"

org $0394BB|!bank
	db $2E,$2E,$2E,$2E,$2C,$2E,$2E,$2E
	db $2E,$2C

org $0394F8|!bank
	JSR.w store_tile1_bank3
