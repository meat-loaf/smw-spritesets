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
	LDA.b #$01
	STA.w !157C,x
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
	JSL sub_spr_gfx_square
	RTS
	
castle_block_props:
	db $03,$03,$03,$03

warnpc $038EEA|!bank
;org $038ECF|!bank
;	JSR.w store_tile1_bank3

