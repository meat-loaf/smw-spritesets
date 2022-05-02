includefrom "remaps.asm"

; bony beetle tilemap
org $019C2D|!bank
	db $20,$22,$24,$26

; crumbling bones tile, frame 1
org $01E454|!bank
	db $09
; crumbling bones tile, frame 2
org $01E45E|!bank
	db $0C
; crubling tile store
org $01E462|!bank
	JSR.w store_tile1_bank1

; init extended bone spriteset offset
org $03C463|!bank
	JSR.w extsprite_spawn_bank3

; dry bones tilemap
; note: the first and fourth frame are skipped (FF here, originally 00):
; it's the bone tile in the throwing animation
org $03C3CE|!bank
	db $FF,$00,$02,$FF,$00,$04,$2A,$00
	db $06

org $03C438|!bank
	JSR.w store_tile1_bank3
