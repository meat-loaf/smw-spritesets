includefrom "remaps.asm"

; bony beetle tilemap
org shared_spr_routines_tile_addr($31)
	db $20,$22,$24,$26

; crumbling bones tile, frame 1
org $01E454|!bank
	db $09
; crumbling bones tile, frame 2
org $01E45E|!bank
	db $0C

dry_bones:
org $01E465|!bank
	BRA.b .cont
	NOP   #4
.cont:
	LDA.w !157C,x
	TAX
	LDA.w $0300|!addr,y
	CLC
	ADC.w $01E43C|!bank,x
	LDX.w $15E9|!addr
warnpc $01E479|!bank

; init extended bone spriteset offset
org $03C463|!bank
	JSR.w extsprite_spawn_bank3

; dry bones tilemap
; note: the first and fourth frame are skipped (FF here, originally 00):
; it's the bone tile in the throwing animation
org $03C3CE|!bank
	db $FF,$00,$02,$FF,$00,$04,$2A,$00
	db $06

