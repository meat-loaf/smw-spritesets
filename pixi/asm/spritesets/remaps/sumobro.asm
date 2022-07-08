includefrom "remaps.asm"

!sumo_head_8x8_l = $0F
!sumo_head_8x8_r = $1F

!sumo_head_16x16_short = $2E
!sumo_head_16x16_tall = $0D

!sumo_body_foot_out_stomp_l = $00
!sumo_body_foot_out_stomp_r = $02

; ligtning remap
org shared_spr_routines_tile_addr($2B)|!bank
	db $26,$36,$26,$36

org $02DE0E|!bank
sumo_bro_tiles:
	db !sumo_head_8x8_l,!sumo_head_8x8_r
	db $07,$08
	db !sumo_head_8x8_l,!sumo_head_8x8_r
	db $0A,$0B
	; ???
	db $FF,$FF
	db $0A,$0B
	db !sumo_head_16x16_short,!sumo_head_16x16_short
	db $04,$05
	db !sumo_head_16x16_tall,!sumo_head_16x16_tall
	db !sumo_body_foot_out_stomp_l,!sumo_body_foot_out_stomp_r
	db !sumo_head_16x16_tall,!sumo_head_16x16_tall
	db !sumo_body_foot_out_stomp_l,!sumo_body_foot_out_stomp_r
warnpc $02DE26|!bank

; TODO revisit
org $02DE7B|!bank
	JSR.w store_tile1_bank2|!bank

; TODO revisit
; sumo bro lightning cluster spawn
org $02DF85|!bank
sumo_lightning_spawn:
	JML.l spawn_sumo_fire|!bank
	NOP
.done
	RTS
warnpc $02DF8B|!bank
pullpc
spawn_sumo_fire:
	LDA.b #$06
	%altsprite_spawn($1892|!addr,!cls_spriteset_offset, \
	         !cluster_sprites_inherit_parent, "!spriteset_offset,x", \
	         !cls_off_on_wram_mirror,cls_sprset_init|!bank, "JML sumo_lightning_spawn_done|!bank")
pushpc
