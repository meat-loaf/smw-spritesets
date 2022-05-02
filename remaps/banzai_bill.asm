includefrom "remaps.asm"

; banzai bill tiles
org $02D5C4|!bank
	db $00,$02,$04,$06,$08,$0A,$24,$26
	db $20,$22,$24,$26,$28,$2A,$04,$06

; banzai bill
org $02D5FF|!bank
	JSR.w store_tile1_bank2
