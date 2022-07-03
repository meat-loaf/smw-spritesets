includefrom "remaps.asm"

org $0382F8|!bank
big_boo_tiles:
	db $20,$22,$0E,$00,$08,$08,$00,$02
	db $09,$09,$02,$04,$0A,$28,$2C,$06
	db $0C,$2A,$2E,$0E,$20,$22,$0E,$00
	db $08,$08,$00,$02,$09,$09,$02,$04
	db $0A,$28,$2C,$06,$0C,$2A,$2E,$0E
	db $20,$22,$0E,$00,$08,$08,$00,$02
	db $09,$09,$02,$04,$0A,$0A,$04,$06
	db $0C,$0C,$06,$0E,$0E,$0E,$24,$26
	db $00,$08,$08,$00,$02,$09,$09,$02
	db $04,$0A,$28,$2C,$06,$0C,$2A,$2E

; instead of the tilestore jsr (which is over 200 cycles here alone...)
; take 8 penalty cyles instead to create the space
org $0383C8|!bank
big_boo_gfx:
	JML.l big_boo_hijack|!bank
.cont:
	ADC.b $03
	STA.b $02
	LDA.w !157C,x
	STA.b $04
	LDA.w !15F6,x
	STA.b $05
	LDA.b $00
.loop
	PHX
	LDX.b $02
	LDA.w big_boo_tiles,x
	CLC
	; we need to fill the space here, and this is one cycle
	; shorter than a NOP
	ADC.w !tile_off_scratch|!dp
	STA.w $0302|!addr,y
warnpc $0383E9|!bank

org $03842B|!bank
	BNE.b .loop
pullpc
big_boo_hijack:
	STA.b $06
	ASL   #2
	STA.b $03
	ASL   #2
	JML.l big_boo_gfx_cont
pushpc
