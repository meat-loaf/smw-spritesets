; motor tiles
org $03C25B|!bank
chainsaw_motor_tiles:
	db $04,$02,$00,$02

!chainsaw_tile_top    = $06
!chainsaw_tile_center = $08
!chainsaw_props_motor = $37

; there's really no need to change the bank byte here, so we don't.
org $03C263|!bank
chainsaw_gfx:
	; support for suboffscreen's destructive return
	JSR.w .self
	RTL
.self:
	JSR.w $03B760|!bank
	; push current sprite slot
	%sprite_num(LDA,x)
	TAX
	; the original routine subtracted 65 from the index,
	; but this is the same, and saves space and runtime to boot.
	LDA.l $03C25F-$65|!bank,x
	STA.b $03
	LDA.l $03C261-$65|!bank,x
	STA.b $04
	LDA.b $14
	AND.b #$02
	STA.b $02
	LDA.b $00
	SEC
	SBC.b #$08
	STA.w $0300|!addr,y
	STA.w $0304|!addr,y
	STA.w $0308|!addr,y
	LDA.b $01
	SEC
	SBC.b #$08
	STA.w $0301|!addr,y
	CLC
	ADC.b $03
	CLC
	ADC.b $02
	STA.w $0305|!addr,y
	CLC
	ADC.b $03
	STA.w $0309|!addr,y
	LDA.b $14
	AND.b #$0C
	LSR   #2
	TAX
	LDA.l chainsaw_motor_tiles|!bank,x
	STA.w $0302|!addr,y
	LDA.b #!chainsaw_tile_center
	STA.w $0306|!addr,y
	LDA.b #!chainsaw_tile_top
	STA.w $030A|!addr,y
	LDA.b #!chainsaw_props_motor
	STA.w $0303|!addr,y
	LDA.b $04
	STA.w $0307|!addr,y
	STA.w $030B|!addr,y
	LDX $15E9|!addr
	LDY.b #$02
	; sneaky way to save a byte and a cycle; from the original
	TYA
	JSL.l $01B7B3|!bank
	RTS
warnpc $03C2D9|!bank
