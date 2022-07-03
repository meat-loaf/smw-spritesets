includefrom "remaps.asm"

org $02EC72|!bank
	; cape 1 (down 2)
	db $09,$19,$1F
	; body (running, normal blue koopa pose)
	db $E0
	; cape 2 (down 2)
	db $0A,$1A,$0F
	; body 2 (running, normal blue koopa pose)
	db $E2
	; cape (flying 1)
	db $0D,$0E
	; koopa's foot + body (flying 1)
	db $11,$07
	; cape (flying 2)
	db $1D,$1E
	; koopa's foot + body (flying 2)
	db $11,$07
	; body (death 1, normal blue koopa pose)
	db $E0
	; cape (death 1)
	db $1B,$0B
	; empty tile (?)
	db $05
	; cape takeoff 1
	db $1C,$0C
	; body (running, normal blue koopa pose)
	db $E2
	; empty tile (?)
	db $05
	; cape takeoff 2
	db $1D,$1E
	; body 2 (running, normal blue koopa pose)
	db $E0
	; empty tile (?)
	db $05
	; cape (takeoff 2)
	db $1D,$1E
	; body (running, normal blue koopa pose)
	db $E2
	; empty tile (?)
	db $05
	; cape takeoff 1
	db $0D,$0E
	; body 2 (running, normal blue koopa pose)
	db $E2
	; empty tile (?)
	db $05
warnpc $02EC96|!bank

org $02ED06
super_koopa:
	JML.l superkoopa_tile_store|!bank
	skip 6
.done
pullpc
superkoopa_tile_store:
	; super koopa tile props
	LDA.w $02EC96|!bank,x
	LSR
	LDA.b #$00
	BCC.b .tile_on_lo_page
	LDA.b !tile_off_scratch
.tile_on_lo_page
	CLC
	; super koopatiles
	ADC.w $02EC72|!bank,x
	STA.w $0302|!addr,y
	JML.l super_koopa_done|!bank
pushpc
