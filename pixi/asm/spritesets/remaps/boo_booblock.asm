includefrom "remaps.asm"

; boo tilemap
org $019C5C|!bank
	db $02,$00,$04,$06,$08,$0A,$00,$02

; boo block tilemap
org $01FA37|!bank
	db $02,$0C,$0E

; boo stream: front boo tilemap
org $038F6D|!bank
	db $02,$00,$04,$06,$08,$0A,$00,$02

; boo stream: aferimage minorextended sprite spawn
org $039039|!bank
	JSR.w mexsprite_spawn_bank3|!bank
