includefrom "remaps.asm"

; frame 1
org $039799|!bank
	db $0A
; frame 2
org $03979D|!bank
	db $0C
; fishbone's tail
org $039788|!bank
	db $09,$09,$19,$19

; head tile store
org $03979E|!bank
	JSR.w store_tile1_bank3

; tail tile store
org $0397E4|!bank
	JSR.w store_tile1_bank3
