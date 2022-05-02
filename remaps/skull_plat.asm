includefrom "remaps.asm"

org $02EE04|!bank
	db $0C
org $02EE08|!bank
	db $0E

org $02EE09|!bank
	JSR.w store_tile1_bank2
