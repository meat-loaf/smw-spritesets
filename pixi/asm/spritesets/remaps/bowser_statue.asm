includefrom "remaps.asm"

org $038B2E|!bank
	; toe (?), head, body (stationary)
	db $11,$00,$02
	; toe, head, body (jumping)
	db $11,$00,$04

; bowser statue fireball
org $038F0B|!bank
	db $16,$17,$06,$07
	db $16,$17,$06,$07
