includefrom "remaps.asm"

; chain of ball 'n' chain
org $02D7A4|!bank
	db $0C

org $02D7BB|!bank
	JSR.w store_tile1_bank2

; ball 'n' chain ball
; TODO the add can be inlined here, potentially. The time wasting routine at $02D800
; can probably be shortened by one byte (it doesnt account for the cycles wasted by
; the call itself...) and we can shove the tile offset here without the JSR
org $02D82B|!bank
	      ; this byte is the tile of the ball!
	LDA.b #$0E
	JSR.w store_tile1_bank2
	NOP
