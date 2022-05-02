includefrom "remaps.asm"

; vert dolphin
org $019C69|!bank
	db $0A,$0C
; fix dolphin tail offscreen bug (190F tweaker table)
org $07F659+$43
	db $25

;horz dolphin
org $02BC0E|!bank
	; head
	db $05,$00
	; body
	db $07,$02
	; tail (intersects)
	db $08,$03

; dolphin
org $02BC65|!bank
	JSR.w store_tile1_bank2
org $02BC6B|!bank
	JSR.w store_tile2_bank2
org $02BC71|!bank
	JSR.w store_tile3_bank2
