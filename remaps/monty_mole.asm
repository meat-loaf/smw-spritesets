includefrom "remaps.asm"

; monty mole: body
org $019C6D|!bank
	db $00,$02,$04
; monty mole: dirt
org $019C70|!bank
	db $06
	db $08,$08,$18,$19,$08,$08,$19,$18
