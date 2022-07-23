; much of this code was adapted from code by imamelia.
decompress_gfx_file = $0FF900|!bank
!decomp_buffer = $7F1500
!current_spriteset        = $5C

init:
    STZ $10
-
    LDA $10
    BEQ -
    STZ $10

    STZ $4200
    LDA #$80
    STA $2100

    JSR SpriteSetHandler

    LDA #$81
    STA $4200
    RTL

SpriteSetHandler:
	PHP
	LDA !current_spriteset
	REP #$30
	AND #$00FF
	ASL : ASL : ASL : ASL
	TAY
	LDX #$0000
.Loop
	STZ $00
	LDA #$7F15
	STA $01
	LDA SpriteSetGFXList,y
	CMP #$007F
	BEQ .skip
	JSL decompress_gfx_file
	TXA
	XBA
	EOR #$7E00
	JSR UploadVRAMData
.skip
	INY : INY
	INX : INX
	CPX #$0010
	BCC .Loop
	PLP
	RTS

; NOTE: The VRAM uploads happen backwards, so the first item is the bottom-most (16 pixel high) row of SP4,
; NOTE: the second row is the second-bottom-most 16-pixel row, and so on.
; NOTE: In other words, the rightmost entry is uploaded at the lowest VRAM address.
SpriteSetGFXList:
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 00: none
	dw $007F,$007F,$0126,$010B,$0109,$0108,$0107,$0110		; spriteset 01: chuck (pitchin), pokey, monty mole, piranha, super koopa
	dw $0110,$0102,$010E,$0103,$010D,$010C,$0108,$0107		; spriteset 02: rex, banzai bill, fish, timed + carrot platforms, piranhas
	dw $007F,$007F,$007F,$007F,$007F,$0116,$0114,$007F		; spriteset 03: dolphins, porcupuffer
	dw $0105,$0110,$0104,$011A,$010A,$0109,$0108,$0107		; spriteset 04: all chucks, spike top, buzzy, swooper, blargg
	dw $007F,$007F,$007F,$0106,$011E,$011D,$011C,$0110		; spriteset 05: ghost house
	dw $007F,$007F,$007F,$007F,$007F,$007F,$011F,$007F		; spriteset 06: lakitu
	dw $0124,$0123,$0122,$0121,$0120,$0119,$0118,$0110		; spriteset 07: castle -- dry bones, thwomps, climbing koopas, etc
	dw $007F,$007F,$007F,$007F,$007F,$0111,$0127,$007F		; spriteset 08: athletic
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 09: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 0A: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 0B: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 0C: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 0D: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 0E: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 0F: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 10: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 11: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 12: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 13: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 14: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 15: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 16: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 16: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 17: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 18: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 19: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 1A: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 1B: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 1C: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 1D: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 1E: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 1F: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 20: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 21: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 22: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 23: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 24: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 25: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 26: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 26: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 27: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 28: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 29: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 2A: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 2B: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 2C: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 2D: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 2E: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 2F: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 30: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 31: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 32: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 33: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 34: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 35: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 36: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 36: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 37: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 38: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 39: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 3A: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 3B: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 3C: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 3D: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 3E: none
	dw $007F,$007F,$007F,$007F,$007F,$007F,$007F,$007F		; spriteset 3F: none

UploadVRAMData:
	PHY
	PHP
	SEP #$10
	LDY #$80
	STY $2115
	STA $2116
	LDA #$1801
	STA $4300
	LDA.w #!decomp_buffer
	STA $4302
	LDY.b #!decomp_buffer>>16
	STY $4304
	;LDA $8D
	LDA #$0400
	STA $4305
	LDY #$01
	STY $420B
	PLP
	PLY
	RTS
