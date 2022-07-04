includefrom "remaps.asm"
org $03882B|!bank
mega_mole_tile_off_x:

org $038833|!bank
mega_mole_tile_off_y:

org $038770|!bank
	JSR.w mega_mole_gfx|!bank
org $03882B|!bank
mega_mole_xoff:
	db $00,$10,$00,$10,$00
mega_mole_yoff:
	db $F0,$F0,$00,$00
mega_mole_tiles:
	db $00,$02,$04,$06,$08,$0A,$0C,$0E
mega_mole_props:
	db $01,$01,$01,$01
mega_mole_gfx:
	; get draw info
	JSR.w $03B760|!bank
	; setup animation frame
	LDA.w !151C,x
	STA.b $02
	LDA.b $14
	LSR   #2
	CLC
	ADC.w $15E9|!bank
	AND.b #$01
	STA.w !1602,x

	REP.b #$20
	LDA.w #mega_mole_tiles
	STA.b $02
	LDA.w #mega_mole_props
	STA.b $04
	LDA.w #mega_mole_xoff
	STA.b $06
	LDA.w #mega_mole_yoff
	STA.b $08
	SEP.b #$20
	JSL.l sub_spr_gfx_square|!bank
	RTS
warnpc $03889F|!bank
