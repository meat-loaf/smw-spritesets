includefrom "remaps.asm"

; non-line guided grinder
; note: first bit ($02; %00000010) should be clear, or it won't animate.
org $01DBBF|!bank
	db $08

; line guided grinder
; note: first bit ($02; %00000010) should be clear, or it won't animate.
org $01DC28|!bank
	db $08
