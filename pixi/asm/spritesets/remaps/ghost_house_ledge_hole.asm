includefrom "remaps.asm"
org $02E63A|!bank
	REP.b #$20
	LDA.w #ledge_hole_tiles
	STA.b $02
	LDA.w #ledge_hole_props
	STA.b $04
	LDA.w #ledge_hole_xoffs
	STA.b $06
	LDA.w #ledge_hole_yoffs
	STA.b $08
	SEP.b #$20

	STZ.b $0A
	JSL.l sub_spr_gfx_square_nofacing|!bank
	RTS
ledge_hole_xoffs:
	db $00,$08,$18,$20
ledge_hole_yoffs:
	db $00,$00,$00,$00
ledge_hole_tiles:
	db $01,$00,$00,$01
ledge_hole_props:
	db $71,$31,$31,$31
warnpc $02E672|!bank
