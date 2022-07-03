includefrom "remaps.asm"

; platform
org $038E05
	db $00,$00
; numbers
org $038E0E
	db $03,$02,$13,$12

org $038E49|!bank
	JSR.w store_tile1_bank3
