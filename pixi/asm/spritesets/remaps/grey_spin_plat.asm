includefrom "remaps.asm"

!wood_platform_props = $33

org $02D797|!bank
	%sprite_x_low(LDA,x)
	STA.b $0A
	%sprite_y_low(LDA,x)
	STA.b $0B
grey_spin_plat:
	LDX.b #$01
.loop
	LDA.b #!brown_plat_ball_tile_num
	CLC
	ADC   !tile_off_scratch
	STA.w $0302|!addr,y
	LDA.b $00
	STA.w $0300|!addr,y
	LDA.b $01
	STA.w $0301|!addr,y
	LDA.b #!wood_platform_props
	STA.w $0303|!addr,y
	CPX.b #$00
	; the below sets up for the next tile...but we dont care for the final tile. Skip it in that case.
	BEQ.b .done

	; the below is the original code
	LDA.b $00
	ADC.b $1A
	SEC
	SBC.b $0A
	STA.b $00
	ASL
	ROR.b $00
	LDA.b $00
	SEC
	SBC.b $1A
	CLC
	ADC.b $0A
	STA.b $00
	LDA.b $01
	CLC
	ADC.b $1C
	SEC
	SBC.b $0B
	STA.b $01
	ASL
	ROR.b $01
	LDA.b $01
	SEC
	SBC.b $1C
	CLC
	ADC.b $0B
	STA.b $01
	INY   #4
	DEX
	BPL .loop
.done
	LDX $15E9|!addr
	LDY.b #$02
	LDA.b #$05
	JSL finish_oam_write|!bank
	RTS
	
warnpc $02D800|!bank

org $02D844|!bank
; ball, platform tiles (left, middle, center)
grey_spin_plat_tiles:
	db $04,$00,$01,$02

org $02D84B|!bank
grey_spin_plat_gfx:
	JML.l grey_spin_plat_gfx_hijack|!bank
.done:
	RTS

pullpc
grey_spin_plat_gfx_hijack:
	LDX.b #$03
.loop:	
	LDA.l grey_spin_plat_tiles,x
	CLC
	ADC.b !tile_off_scratch
	STA.w $0302|!addr,y
	LDA.b #!wood_platform_props
	STA.w $0303|!addr,y
	LDA.b $00
	ADC.l $02D840|!bank,x
	STA.w $0300|!addr,y
	LDA.b $01
	STA.w $0301|!addr,y
	INY   #4
	DEX
	BPL.b .loop
	LDX.w $15E9|!addr
	JML.l grey_spin_plat_gfx_done|!bank
pushpc
