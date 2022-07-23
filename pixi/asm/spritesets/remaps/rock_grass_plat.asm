includefrom "remaps.asm"

org $01B383
grass_rock_plat_tiles:
db $05,$08,$06,$08,$05,$09,$06,$08  ; \ grass platform
db $05                              ; /

db $00,$03,$01,$03,$00,$03,$01,$03  ; \ floating rock
db $00                              ; /

org $01B398|!bank
rockplat_gfx:
	; previously: get draw info
	STZ.b $00     ; flag for drawing sprite $5E
	%sprite_num(LDA,x)
	STA.b $04
	CMP.b #$5E
	BNE .nowide
	INC.b $00     ; saves reloading oam index
.nowide
	LDA.w !15F6,x
	STA.b $03
	%sprite_x_low(LDA,x)
	SEC
	SBC.b $1A
	STA $05       ; is this the same as $00 after getdrawinfo?
	%sprite_y_low(LDA,x)
	SEC
	SBC.b $1C
	STA.w $0301|!addr,y
	STA.w $0309|!addr,y
	STA.w $0311|!addr,y
	LDX.b $00
	BEQ.w .nolong_1
	STA.w $0319|!addr,y
	STA.w $0321|!addr,y
.nolong_1:
	CLC
	ADC.b #$10
	STA.w $0305|!addr,y
	STA.w $030D|!addr,y
	LDX.b $00
	BEQ.b .nolong_2
	STA.w $0315|!addr,y
	STA.w $031D|!addr,y
.nolong_2:
	LDA.b #$08
	LDX.b $00
	BNE.b .nolong_3
	LDA.b #$04
.nolong_3:
	STA.b $01
	DEC
	STA.b $02
	LDA.b $04              ; sprite number
	CMP.b #$5B
	LDA.b #$00
	BCS .is_grass
	LDA.b #$09
.is_grass:
	TAX
	LDA.b $05              ; x_pos
.tile_loop:
	STA.w $0300|!addr,y
	CLC
	ADC.b #$08
	STA.b $05
	LDA.w $01B383|!bank,x
	STA $0302|!addr,y
	LDA.b $01
	CMP.b $02
	LDA.b $64
	ORA.b $03
	BCS .noflip
	ORA.b #$40
.noflip:
	STA $0303|!addr,y
	INY #4
	INX
	LDA.b $05
	DEC.b $01
	BPL .tile_loop
	LDX.w $15E9|!addr
	LDA.b $00
	; inverted from the original: the original game special cased the smaller platforms.
	; instead, we special-cased the longer platform and modified the tilemaps above accordingly
	BEQ.b .done
	LDY.w !15EA,x
              ; tile number of the top center of the grass platform (for long plat)
	LDA.b #$06
	STA.w $0312|!addr,y
              ; tile number of the bottom center of the grass platform (for long plat)
	LDA.b #$09
	STA $030E|!addr,y
.done:
	LDY.b $00
	LDA .tiles_drawn,y
	LDY.b #$02
	; finish oam write
	JMP.w _finish_oam_write|!bank
.tiles_drawn:
	db $04,$08
warnpc $01B450|!bank
