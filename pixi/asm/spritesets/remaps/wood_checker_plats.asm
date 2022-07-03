includefrom "remaps.asm"
; rewrite the tile store for sprites 55, 57, 5B, 5C, 62, and 63
; technically its now slower than before but it fits in the alotted space (barely)
; far better than the 'insert jsrs for each tile store' solution though'
org $01B326|!bank
	LDX.b #$00
	LDA.b $01
	BEQ.b .wood
	LDX.b #$03
.wood:
	CLC
	LDA.w plat_tiles|!bank,x
	ADC !tile_off_scratch
	STA $0302|!addr,y
	INX
	LDA.w plat_tiles|!bank,x
	ADC !tile_off_scratch
	STA $0306|!addr,y
	INX
	LDA.w plat_tiles|!bank,x
	ADC !tile_off_scratch
	STA $030A|!addr,y
	STA $030E|!addr,y
	INX
	LDA.w plat_tiles|!bank,x
	ADC !tile_off_scratch
	STA $0312|!addr,y
	LDX $15E9|!addr
	NOP
warnpc $01B359|!bank

org $01B359|!bank
.props:
org $01B36D|!bank
	BRA skip
;	NOP #7
; these can be moved elsewhere in bank 2 and the routine shortened if you wish.
; $01B37E is jumped to by a handful of other sprite routines though

; note| the routine hijacked above draws only 48px wide wood platforms: there is a check
; note| before the finishoamwrite call for the number of tiles to set up, so it doesnt
; note| draw junk
plat_tiles:
	; wood: left, center, right
	db $00,$01,$02
	; wood: left, center, center, right
	db $06,$07,$07,$08
skip:
warnpc $01B376|!bank
