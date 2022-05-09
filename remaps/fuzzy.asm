includefrom "remaps.asm"

; part of the grinder's gfx routine...
org $01DBD2|!bank
	BRA.b fuzz_gfx_hijack_fin

!fuzzy_tile = $0E

org $01DBED|!bank
fuzz_gfx_hijack:
	LDA.b $14
	; ANDing first guarantees free carry clear
	AND.b #$04
	LSR   #2
	TAX
	LDA.b #!fuzzy_tile
	ADC.b !tile_off_scratch
	STA.w $0302|!addr,y
	LDA.w $01DC09|!bank,x
	ORA.b $64
	STA.w $0303|!addr,y
	LDA.b #$00
.fin
	PLX
	JMP.w $01B37E|!bank
warnpc $01DC0A|!bank
