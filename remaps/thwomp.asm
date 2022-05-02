includefrom "remaps.asm"

; thwomp tilemap
org $01AF4A|!bank
	db $00,$00,$02,$02,$04
; thwomp angry face
org $01AF8D
	db $06

org $01AF8F|!bank
	JSR.w store_tile1_bank1
