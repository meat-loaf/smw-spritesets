includefrom "remap.asm"

; shell koopas should be row above
if !remap_koopa
	db $10,$12,$14,$16,$18,$1A
	db $00,$04,$02,$08
else
org $019C03|!bank
	db $00,$02,$04,$06,$08,$0A
	db $82,$A0,$84,$A4
; TODO what do do when remapping koopas?
org $01B9EC|!bank
	LDA !spriteset_offset,x
	PHA
if !spriteset_off_on_wram_mirror
	STZ !spriteset_offset,x
else
	LDA #$00
	STA !spriteset_offset,x
endif
	JSR.w $9D67
	JML.l climbing_koopa_hack
warnpc $01B9FA|!bank
pullpc
climbing_koopa_hack:
	PLA
	STA !spriteset_offset,x
	PLA
	STA !15F6,x
	PLA
	STA !14D4,x
	PLA
	STA !D8,x
	JML.l $01800D|!bank           ; bank 1 rts
pushpc
endif
