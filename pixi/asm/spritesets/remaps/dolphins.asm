includefrom "remaps.asm"

; vert dolphin
org $019C69|!bank
	db $0A,$0C
; fix dolphin tail offscreen bug (190F tweaker table)
org $07F659+$43
	db $25

org $02BB94|!bank
	JSR.w dolphin_gfx

org $02BC00|!bank
dolphin_head_tiles:
	db $05,$00
dolphin_body_tiles:
	db $07,$02
dolphin_tail_tiles:
	db $08,$03
horz_dolphin_xpos_off_table:
	db $00,$10,$08
	db $18,$F0,$F8
dolphin_gfx:
	%sprite_num(LDA,x)
	CMP.b #$43
	BEQ vert_dolphins
horz_dolphins:
	; get draw info
	JSR.w $02D378|!bank
	; sa1 ok
	LDA.b !B6,x
	AND.b #$80
	; you can remove this if you flip
	; the gfx
	EOR.b #$80
	LSR
	STA.b $02
	TAX
	BEQ.b .noflip
	LDX.b #$03
.noflip
	LDA.b $00
	CLC
	ADC.w horz_dolphin_xpos_off_table,x
	STA.w $0300|!addr,y
	CLC
	ADC.w horz_dolphin_xpos_off_table+1,x
	STA.w $0304|!addr,y
	CLC
	ADC.w horz_dolphin_xpos_off_table+2,x
	STA.w $0308|!addr,y
	LDA.b $14
	AND.b #$08
	LSR   #3
	TAX
	LDA.w dolphin_head_tiles,x
	ADC.b !tile_off_scratch
	STA.w $0302|!addr,y
	LDA.w dolphin_body_tiles,x
	ADC.b !tile_off_scratch
	STA.w $0306|!addr,y
	LDA.w dolphin_tail_tiles,x
	ADC.b !tile_off_scratch
	STA.w $030A|!addr,y
	LDX.w $15E9|!addr
	LDA.w !15F6,x
	ORA.b $64
	ORA.b $02
	STA.w $0303|!addr,y
	STA.w $0307|!addr,y
	STA.w $030B|!addr,y
	; tile y pos
	LDA.b $01
	STA $0301|!addr,y
	STA $0305|!addr,y
	STA $0309|!addr,y
	LDA.b #$02
	; jumped to below, bytes needed here
	; LDY.b #$02
	JMP.w $02B7A5|!bank
vert_dolphins:
	LDA.b $14
	AND.b #$04
	LSR   #2
	STA.w !157C,x
	; generic spr gfx 1
	JSL.l $019D5F|!bank
	RTS
warnpc $02BC8C|!bank
