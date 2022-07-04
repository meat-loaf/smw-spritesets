includefrom "remaps.asm"

!dino_skooshed_tile = $04

; squished dino torch
org $019B0A|!bank
	LDA.b #!dino_skooshed_tile
	JMP.w store_tile1_bank1
	; now-unused RTS here

org $039C47|!bank
	JSR.w dino_gfx|!bank

org $039DFE|!bank
dino_torch_x_displ:
	skip $0A
dino_torch_y_displ:
	skip $0A
dino_torch_flame_tiles:
	db $20,$22,$24,$26,$00,$28,$2A,$2C
	db $2E,$00
dino_torch_props:
	db $09,$05,$05,$05,$0F
; walking x2, fire breathe l/r, fire breathe up
dino_torch_tiles:
	db $02,$00,$06,$08
dino_rhino_x_displ:
	db $F8,$08,$F8,$08,$F8
dino_rhino_props:
	db $2F,$2F,$2F,$2F
dino_rhino_y_displ:
	db $F0,$F0,$00,$00
; walk 1 (x4), walk 2 (x4)
dino_rhino_tiles:
	db $40,$42,$44,$46,$40,$42,$48,$4A

org $039E49|!bank
dino_gfx:
	JSR.w $03B760             ; get draw info: bank 3
	%sprite_num(LDA,x)
	CMP.b #$6F
	BEQ.b dino_torch
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
; this is practically just the original, just relocated
dino_torch:
	LDA.w !157C,x
	STA.b $02
	LDA.w !151C,x
	STA.b $03
	LDA.w !1602,x
	STA.b $04
	LDA.b $14
	AND.b #$02
	ASL   #5
	LDX.b $04
	CPX.b #$03
	BEQ +
	ASL
+
	STA.b $05
	LDX.b #$04
.loop:
	STX.b $06
	LDA.b $04
	CMP.b #$03
	BNE +
	TXA
	CLC
	ADC.b #$05
	TAX
+
	PHX
	LDA.w dino_torch_x_displ,x
	LDX.b $02
	BNE +
	EOR.b #$FF
	INC A
+
	PLX
	CLC
	ADC.b $00
	STA.w $0300|!addr,y
	LDA.w dino_torch_y_displ,x
	CLC
	ADC.b $01
	STA.w $0301|!addr,y
	LDA.b $06
	CMP.b #$04
	BNE .draw_flame
	LDX.b $04
	LDA.w dino_torch_tiles,x
	BRA +
.draw_flame:
	LDA.w dino_torch_flame_tiles,x
+
	CLC
	ADC.b !tile_off_scratch
	STA.w $0302|!addr,y
	LDA.b #$00
	LDX.b $02
	BNE +
	ORA.b #$40
+
	LDX.b $06
	CPX.b #$04
	BEQ +
	EOR.b $05
+
	ORA.w dino_torch_props,x
	ORA.b $64
	STA.w $0303|!addr,y
	INY   #4
	DEX
	CPX.b $03
	BPL .loop
	LDX.w $15E9|!addr
	LDY.w !151C,x
	LDA.w dino_tiles_written,y
	LDY.b #$02
	JSL.l finish_oam_write
	RTS
dino_tiles_written:
	db $04,$03,$02,$01,$00
warnpc $039F38|!bank
