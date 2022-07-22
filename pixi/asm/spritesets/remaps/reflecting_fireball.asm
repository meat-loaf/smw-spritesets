org $039011|!bank
	db $0E

; note: this sprite uses the generic sprite graphics routine, then
; updates its tile afterwards.
org $039012|!bank
	JSR.w store_tile1_bank3
