includefrom "remaps.asm"

; rex tiles
org $039670|!bank
	db $00,$06,$00,$08,$00,$06,$02,$02
	db $04,$04,$1A,$1B

org $0396C6|!bank
	JSR.w store_tile1_bank3
