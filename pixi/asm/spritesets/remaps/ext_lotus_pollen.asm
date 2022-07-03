includefrom "remaps.asm"

; frame 1
org $029B94|!bank
	db $06
; frame 2
org $029B98|!bank
	db $16

org $029B99|!bank
	JSR.w ext_store_tile1_lo_bank2|!bank
