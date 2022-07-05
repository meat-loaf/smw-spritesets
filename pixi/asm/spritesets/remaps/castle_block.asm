includefrom "remap.asm"

org $038EA8|!bank
castle_block_xoff:
	db $00,$10,$00,$10
castle_block_yoff:
	db $00,$00,$10,$10
castle_block_tiles:
	db $00,$02,$04,$06

org $038EB7|!bank
; getdrawinfo call above
castle_block_gfx:
	REP.b #$20
	LDA.w #castle_block_tiles
	STA.b $02
	LDA.w #castle_block_props
	STA.b $04
	LDA.w #castle_block_xoff
	STA.b $06
	LDA.w #castle_block_yoff
	STA.b $08
	SEP.b #$20

	STZ.b $0A
	JSL sub_spr_gfx_square_nofacing|!bank
	RTS
	
castle_block_props:
	db $03,$03,$03,$03
warnpc $038EEA|!bank

