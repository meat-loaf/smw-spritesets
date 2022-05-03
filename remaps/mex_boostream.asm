includefrom "remaps.asm"

; boo stream tiles
org $028CB8|!bank
	db $02,$06,$08,$00,$04,$0A,$02,$06
	db $08,$00,$04,$0A

; boo stream tile store
org $028D26|!bank
	JSR.w mex_store_tile1_lo_bank2|!bank
