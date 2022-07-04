includefrom "remaps.asm"

org $039E25|!bank
dino_rhino_x_displ:
; 3 (now) unused bytes after this
db $F8,$08,$F8,$08,$F8

org $039E2D|!bank
dino_rhino_props:
	
org $039E35|!bank
dino_rhino_y_displ:

org $039E39|!bank
dino_rhino_tiles:

;org $039E5C|!bank
org $039E49|!bank
dino_gfx:
	JSR.w $03B760             ; get draw info: bank 3
	%sprite_num(LDA,x)
	CMP.b #$6F
	BEQ.b .torch
	REP.b #$20                ; same cycle count as not changing M
	LDA.w #dino_rhino_tiles
	STA.b $02
	LDA.w #dino_rhino_props
	STA.b $04
	LDA.w #dino_rhino_x_displ
	STA.b $06
	LDA.w #dino_rhino_y_displ
	STA.b $08
	SEP.b #$20
	JSL.l sub_spr_gfx_square|!bank
	RTS
; TODO
.torch:
	LDA.w !157C,x
	STA.b $02
	BRA.b .torch_cont
warnpc $039EA9|!bank
org $039EA9|!bank
.torch_cont:
org $039F36|!bank
