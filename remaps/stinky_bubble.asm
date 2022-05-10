
; stinky gas bubble
org $02E372|!bank
	db $00,$02,$04,$06,$08,$09,$0A,$0C
	db $08,$09,$0A,$0C,$00,$02,$04,$06

;org $02E3FF|!bank
;	JSR.w store_tile1_bank2
org $02E3C6|!bank
stinky_bubble_hijack:
.loop
org $02E3E1|!bank
	LDA.w $02E372|!bank,x
	CLC
	ADC.b !tile_off_scratch
	STA.w $0302|!addr,y
	LDA.b $01
	ADC.w $02E362|!bank,x
	PHA
	LDA.w $02E392|!bank,x
	AND.b #$01
	BNE.b .E3F5_old
	PLA
	CLC
	ADC.b $03
	BRA.b .store_y
.E3F5_old:
	PLA
	SEC
	SBC.b $03
.store_y:
	STA.w $0301|!addr,y
	LDA.w $02E382|!bank,x
	STA.w $0303|!addr,y
	INY #4
	DEX
	BPL.b .loop
	PLX
	LDA.B #$0F
	JMP.w call_finoamwrite_square_bank2_bigtile_only
warnpc $02E417|!bank
