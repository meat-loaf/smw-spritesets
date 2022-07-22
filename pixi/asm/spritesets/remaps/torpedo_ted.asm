includefrom "remaps.asm"

!torpedo_ted_head_tile = $04
!torpedo_ted_rotor_tile_1 = $06
!torpedo_ted_rotor_tile_2 = $08

!torpedo_ted_arm_tile_hold = $00
!torpedo_ted_arm_tile_release = $02

org $02B92C|!bank
	LDA.b #!torpedo_ted_head_tile
org $02B937|!bank
	db !torpedo_ted_rotor_tile_1
org $02B93F|!bank
	db !torpedo_ted_rotor_tile_2
org $02B942|!bank
	LDA.b #!torpedo_ted_rotor_tile_1

; extended launcher arm
org $029E66|!bank
	db !torpedo_ted_arm_tile_hold
org $029E6A|!bank
	db !torpedo_ted_arm_tile_release
	JSR.w ext_store_tile1_lo_bank2

; TODO this could be better
; launcher arm spawn (by shooter)
org $02B421|!bank
torpedo_ext_shooter_spawn:
	JML.l torpedo_ted_arm_spawn|!bank
.ret:
	RTS
org $02B432|!bank
.cont:

pullpc
torpedo_ted_arm_spawn:
	LDY.b #$07
.loop
	LDA.w $170B|!addr,y
	BEQ.b .do_spawn
	DEY
	BPL.b .loop
	PLX
	JMP.w torpedo_ext_shooter_spawn_ret|!bank
.do_spawn:
	LDA.b #$08
	%altsprite_spawn($170B|!addr,!ext_spriteset_offset, \
	         !extended_sprites_inherit_parent, "!spriteset_offset,x", \
	         !ext_off_on_wram_mirror,ext_sprset_init|!bank, "PLX : JML.l torpedo_ext_shooter_spawn_cont|!bank")
pushpc
