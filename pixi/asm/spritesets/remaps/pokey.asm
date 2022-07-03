includefrom "remaps.asm"

; pokey head tile: dead state
org $02B68D|!bank
	db $0A
; pokey body tile: dead state
org $02B691|!bank
	db $0C
; pokey body tile
org $02B78C|!bank
	db $0C
; pokey head tile
org $02B790|!bank
	db $0A

; pokey: state 08
org $02B692|!bank
	JSR.w store_tile1_bank2
; pokey: state 02
org $02B791|!bank
	JSR.w store_tile1_bank2

