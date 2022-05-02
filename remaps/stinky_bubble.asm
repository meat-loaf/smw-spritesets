
; stinky gas bubble
org $02E372|!bank
	db $00,$02,$04,$06,$08,$09,$0A,$0C
	db $08,$09,$0A,$0C,$00,$02,$04,$06

org $02E3FF|!bank
	JSR.w store_tile1_bank2
