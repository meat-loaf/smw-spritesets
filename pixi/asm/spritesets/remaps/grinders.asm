includefrom "remaps.asm"

; non-line guided grinder
; note: first bit ($02; %00000010) should be clear, or it won't animate.
org $01DBBF|!bank
	db $08

;org $01BDC0|!bank
org $01DBC0|!bank
	JSR.w store_tile1_bank1

; line guided grinder
; note: first bit ($02; %00000010) should be clear, or it won't animate.
org $01DC28|!bank
	db $08

;org $01BD29|!bank
org $01DC29|!bank
	JSR.w store_tile1_bank1
