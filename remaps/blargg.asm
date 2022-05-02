includefrom "remaps.asm"

org $03A075|!bank
	db $00
org $03A076|!bank
	JSR.w store_tile1_bank3

org $03A091|!bank
	db $02,$04,$08,$0A,$06,$02,$04,$0E,$0C,$06

org $03A0D4|!bank
	JSR.w store_tile1_bank3
