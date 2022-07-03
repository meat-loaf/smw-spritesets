includefrom "remaps.asm"

; carrot top tiles
org $038D18|!bank
	db $08,$04,$06,$08,$04,$06

; carrot lift
org $038D49|!bank
	JSR.w store_tile1_bank3
