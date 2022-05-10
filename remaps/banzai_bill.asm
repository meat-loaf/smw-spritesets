includefrom "remaps.asm"

org $02D5C4|!bank
banzai_bill_tiles:
	db $00,$02,$04,$06,$08,$0A,$24,$26
	db $20,$22,$24,$26,$28,$2A,$04,$06

org $02D5E4|!bank
banzai_bill_gfx:
	JSR.w $02D378|!bank
	PHX
	LDX.b #$0F
.loop:
	LDA.w banzai_bill_tiles,x
	CLC
	ADC.b !tile_off_scratch
	STA.w $0302|!addr,y
	LDA.b $00
	ADC.w $02D5A4|!bank,x
	STA.w $0300|!addr,y
	LDA.b $01
	CLC
	ADC.w $02D5B4|!bank,x
	STA.w $0301|!addr,y
	LDA.w $02D5D4|!bank,x
	STA.w $0303|!addr,y
	INY #4
	DEX
	BPL .loop
	PLX
	LDA.b #$0F
	JMP.w call_finoamwrite_square_bank2_bigtile_only
warnpc $02D617|!bank
