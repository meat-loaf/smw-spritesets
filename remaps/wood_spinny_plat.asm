includefrom "remaps.asm"


; NOTE: the brown plat ball tile is in the main spritesets.asm file.
; NOTE: look for the `brown_plat_ball_tile_num' define.

org $01C9BB|!bank
brown_chain_plat_tiles:
	db $00,$01,$01,$02

org $01C8F7|!bank
	JSR.w store_tile1_bank1

org $01C7E9|!bank
	LDA.b !precalc_single_scratch
	STA.w $0302|!bank,y
org $01C870|!bank
	LDA.b !precalc_single_scratch
	STA.w $0302|!bank,y
org $01C8C6|!bank
	LDA.b !precalc_single_scratch
	STA.w $0302|!bank,y
