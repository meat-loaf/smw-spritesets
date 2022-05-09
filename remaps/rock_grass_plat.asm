includefrom "remaps.asm"

org $01B383
grass_rock_plat_tiles:
db $05,$08,$06,$09,$06,$09,$06,$08  ; \ grass platform
db $05                              ; /

db $00,$03,$01,$89,$01,$89,$01,$03  ; \ floating rock
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
; TODO sa1 support
	LDA.b $E4,x
	SEC
	SBC.b $1A
	STA $05       ; is this the same as $00 after getdrawinfo?
; TODO sa1 support
	LDA.b $D8,x
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
	CLC
	ADC.b !tile_off_scratch
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
	BNE.b rock_grass_done
	LDY.w !15EA,x
	LDA.b $04
	CMP.b #$5B
	JML rock_grass_finish|!bank     ; oops i ran out of room
warnpc $01B444|!bank
pullpc
; TODO| why are these patched up like this? see if we can skip this
; TODO| and remove the need for freespace...we can probably invert
; TODO| the condition and 'patch up' the long platform instead
; TODO| of the short ones, then change the tilemaps above accordingly
rock_grass_finish:
	BCC .draw_rock_rhs
	CLC
              ; tile number of the top end of the grass platform
	LDA.b #$05
	ADC.b !tile_off_scratch
	STA.w $0312|!addr,y
              ; tile number of the bottom end of the grass platform
	LDA.b #$08
	ADC !tile_off_scratch
	STA $030E|!addr,y
	JML rock_grass_done|!bank
.draw_rock_rhs:
              ; tile number of the top end of the rock platform
	LDA.b #$00
	ADC.b !tile_off_scratch
	STA $0312|!addr,y
              ; tile number of the bottom end of the rock platform
	LDA.b #$03
	ADC.b !tile_off_scratch
	STA $030E|!addr,y
	JML rock_grass_done|!bank
pushpc
org $01B444|!bank
rock_grass_done:
