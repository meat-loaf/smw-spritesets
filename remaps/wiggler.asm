includefrom "remaps.asm"

; body
org $02F10C|!bank
	db $02,$04,$06,$02
; head
org $02F10E|!bank
	db $00
; angry eyes
org $02F1BE
	db $08

; flower (note: becomes an extended sprite when knocked off)
org $02F1E4
	db $18
