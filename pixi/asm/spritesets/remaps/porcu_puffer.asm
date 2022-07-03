includefrom "remaps.asm"

org $038593|!bank
	db $00,$02,$04,$06,$00,$02,$04,$08

org $0385DF|!bank
	JSR.w store_tile1_bank3
