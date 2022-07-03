includefrom "remaps.asm"

!blink_eyes_open_tile   = $0D
!blink_eyes_closed_tile = $1D
!eye_props              = $05

org $02BE95|!bank
hothead_tiles:
	db $09,$0B,$0B,$09,$0B,$09,$09,$0B

org $02BEB5|!bank
hothead_gfx:
	; get draw info
	JSR.w $02D378|!bank
	LDA.w !1558,x       ; blinking timer
	PHA
	; sa1 ok
	LDA.b !C2,x
	TAX
	LDA.b $00
	CLC
	ADC.w $02BEA5|!bank,x
	STA.w $0300|!addr,y
	LDA.b $01
	CLC
	ADC.w $02BEAD|!bank,x
	STA.w $0301|!addr,y
	LDA.b #!blink_eyes_open_tile
	PLX
	BEQ .noblink
	LDA.b #!blink_eyes_closed_tile
.noblink:
	CLC
	ADC.b !tile_off_scratch
	STA.w $0302|!addr,y
	LDA.b #!eye_props
	ORA.b $64
	STA.w $0303|!addr,y

; draw body
	LDA.b $14
	AND.b #$04
	STA.b $03
	LDX.b #$03
.body_loop:
	LDA.b $00
	CLC
	ADC.w $02BE8D|!bank,x
	STA.w $0304|!addr,y
	LDA.b $01
	CLC
	ADC.w $02BE91|!bank,x
	STA.w $0305|!addr,y
	PHX
	TXA
	ORA.b $03
	TAX
	LDA.w hothead_tiles|!bank,x
	CLC
	ADC.b !tile_off_scratch
	STA.w $0306|!addr,y
	LDA.w $02BE9D|!bank,x
	ORA.b $64
	STA.w $0307|!addr,y
	INY   #4

	PLX
	DEX
	BPL .body_loop
	LDX.w $15E9|!addr
	LDA.w !15EA,x
	LSR   #2
	TAY
	LDA.b #$00
	STA.w $0460|!addr,y
	LDA.b #$02
	STA.W $0461|!addr,y
	STA.w $0462|!addr,y
	STA.w $0463|!addr,y
	STA.w $0464|!addr,y

	LDY.b #$FF
	LDA.b #$04
	JSL.l $01B7B3|!bank
	RTS
; there's a handful of bytes free here now
warnpc $02BF4C|!bank
