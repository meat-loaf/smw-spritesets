org $03C493|!bank
	db $00,$02,$04,$06,$08,$0A,$0C,$0E,$0E

org $03C4C0|!bank
	TAX
	JML.l disco_tile_store
pullpc
; a dumb way to do this but i dont particularly care to
; rewrite this gfx routine much.
disco_tile_store:
	STX.b $8A
	LDX.w $15E9|!addr
	LDA   !spriteset_offset,x
	LDX.b $8A
	CLC
	ADC.w $03C493|!bank,x
	STA.w $0302|!addr,y
	JML.l $03C4C7|!bank
pushpc
