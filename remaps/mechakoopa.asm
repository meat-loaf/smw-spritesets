includefrom "remaps.asm"

; mechakoopa: body frames
org $03B32F|!bank
	; 4 walking frames
	; head, hair, bottom of mouth, feet 1
	db $00, $03, $13, $04
	; head, hair, bottom of mouth, feet 2
	db $00, $03, $13, $06
	; head, hair, bottom of mouth, feet 3
	db $00, $03, $13, $08
	; head, hair, bottom of mouth, feet 4
	db $00, $03, $13, $0A
	; stunned frame
	; full head, top rightmost,
	; bottom leftmost, right
	db $0C,$0E,$1C,$0D
	; stunned frame, again?
	; full head, top rightmost,
	; bottom leftmost, right
	db $0C,$0E,$1C,$0D

; mechakoopa body tile store
; todo| there's probably enough room here to add the tileoffset in
; todo| without the JSR, and to optimize drawing the key
org $03B3CE|!bank
	JSR.w store_tile1_bank3

; mechakoopa: wind up key frames
org $03B3EF|!bank
	db $F9,$0F,$4D,$0D
org $03B3F3
	db $0F,$02,$12,$02

; mechakoopa: key tile store
org $03B42F|!bank
	JSR.w store_tile1_bank3

