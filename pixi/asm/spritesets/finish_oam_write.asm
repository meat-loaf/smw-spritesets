org $018E5B|!bank
	JMP.w _finish_oam_write|!bank
; generic sprgfx routine 0 handled by rewrite
;org $019D5B|!bank
;	JMP.w _finish_oam_write|!bank
org $01B380|!bank
	JMP.w _finish_oam_write|!bank
org $01B69C|!bank
	JMP.w _finish_oam_write|!bank
org $01BD95|!bank
	JMP.w _finish_oam_write|!bank
org $01C172|!bank
	JMP.w _finish_oam_write|!bank
org $01D4E4|!bank
	JMP.w _finish_oam_write|!bank
org $01DC06|!bank
	JMP.w _finish_oam_write|!bank
org $01E266|!bank
	JMP.w _finish_oam_write|!bank
org $01E4B0|!bank
	JSR.w _finish_oam_write|!bank
org $01E94E|!bank
	JSR.w _finish_oam_write|!bank
org $01E95B|!bank
	JSR.w _finish_oam_write|!bank
org $01FF4F|!bank
	JMP.w _finish_oam_write|!bank

; stick tile offset in finishoamwrite
org $01B7B3|!bank
finish_oam_write:
; the phb/phk/plb rapper isnt at all necessary, so don't do it
JSR.w _finish_oam_write|!bank
RTL
; this is an optimized version of the routine, yoinked from PIXI
; attributed to Akaginite
_finish_oam_write:
	STY $0B
	STA $08
	LDA !spriteset_offset,x
	STA $0A

	LDA !D8,x
	SEC
	SBC $1C
	STA $00
	LDA !14D4,x
	SBC $1D
	STA $01
	LDY !15EA,x
	LDA !14E0,x
	XBA
	LDA !E4,x
	REP #$20
	SEC
	SBC $1A
	STA $02
	TYA
        LSR #2
	TAX
	SEP #$21

.loop:
	LDA $0300|!addr,y
	SBC $02
	REP #$21
	BPL +
	ORA.w #$FF00
+
	ADC $02
	CMP.w #$0100
	TXA
	SEP #$20
	LDA $0B
	BPL +
	LDA $0460|!addr,x
	AND #$02
+
	ADC #$00
	STA $0460|!addr,x
	LDA $0301|!addr,y
	SEC
	SBC $00
	REP #$21
	BPL +
	ORA.w #$FF00
+
	ADC $00
	CLC
	ADC.w #$0010
	CMP.w #$0100
	BCC .next
	LDA.w #$00F0
	SEP #$20
	STA $0301|!addr,y
.next:
	SEP #$21
	LDA $0302|!addr,y
	BMI .no_tileoff
	CLC
	ADC $0A
	STA $0302|!addr,y
	SEC
.no_tileoff
	INY #4
	INX
	DEC $08
	BPL .loop
	LDX $15E9|!addr
	RTS
warnpc $01B844|!bank
