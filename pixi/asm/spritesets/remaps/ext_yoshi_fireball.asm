includefrom "remaps.asm"

!yoshi_fireball_tile_1 = $04
!yoshi_fireball_tile_2 = $06

if !yoshi_fireball_on_sp0_sp1 == 1
	!yoshi_fireball_props = pack_props($00,$03,$02,$00)
else
	!yoshi_fireball_props = pack_props($00,$03,$02,$01)
endif

org $029F79|!bank
	LDA.b #!yoshi_fireball_tile_1
	BCC +
	LDA.b #!yoshi_fireball_tile_2
+
if !yoshi_fireball_on_sp0_sp1 == 0
	JSR.w ext_store_tile1_lo_bank2
else
	STA.w $0202|!addr,y
endif
	LDA.w $1747|!addr,x
	AND.b #$80
	EOR.b #$80
	LSR A
	ORA.b #!yoshi_fireball_props
	STA.w $0203|!addr,y
