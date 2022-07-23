includefrom "remaps.asm"
; rewrite the tile store for sprites 55, 57, 5B, 5C, 62, and 63
org $01B326|!bank
plats:
	LDX.b #$00
	LDA.b $01
	BEQ.b .wood
	LDX.b #$03
.wood:
	LDA.w .plat_tiles+$00|!bank,x
	STA $0302|!addr,y
	LDA.w .plat_tiles+$01|!bank,x
	STA $0306|!addr,y
	LDA.w .plat_tiles+$02|!bank,x
	STA.w $030A|!addr,y
	STA.w $030E|!addr,y
	LDA.w .plat_tiles+$03|!bank,x
	STA.w $0312|!addr,y

	LDX.w $15E9|!addr
	LDA.b $64
	ORA.w !15F6,x
	STA.w $0303|!addr,y
	STA.w $0307|!addr,y
	STA.w $030B|!addr,y
	STA.w $030F|!addr,y
	STA.w $0313|!addr,y
	LDA.b #$02
	LDY.b $01
	BEQ.b .wood2
	LDA.b #$04
.wood2:
	LDY.b #$02
	JSL.l finish_oam_write|!bank
	RTS

.plat_tiles:
	; wood: left, center, right
	db $00,$01,$02
	; checker: left, center, center, right
	db $06,$07,$07,$08
; theres about 18 bytes or so free here
; $01B37E is jumped to by a handful of other sprite routines, so its best not to overwrite
warnpc $01B37E|!bank
org $01B37E|!bank
.skip:
