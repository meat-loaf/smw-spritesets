; extended bone, frame 1
org $02A2CC|!bank
	db $28
; extended bone, frame 2
org $02A2D0|!bank
	db $2A

; extended bone tilestore
org $02A2D1|!bank
	JSR.w ext_store_tile1_lo_bank2
