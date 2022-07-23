includefrom "remaps.asm"

; lakitu body tiles
org $019BEE|!bank
	db $0A,$08,$06,$08,$0C,$08

org $01E922|!bank
	db $60
org $01E923|!bank
	STA $0302|!addr,y

; lakitu's cloud smiley face
org $01E976|!bank
	db $15

; fishin' lakitu: fishin' rod
org $02E6A8|!bank
	db $0E

; fishin' lakitu: fishin' line
org $02E707|!bank
	db $05

org $02E9E6|!bank
; pipe lakitu: head tiles
	db $0A,$0C,$06
; pipe lakitu: body tiles
	db $08,$08,$08
