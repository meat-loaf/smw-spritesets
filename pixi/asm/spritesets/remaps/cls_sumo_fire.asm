includefrom "remaps.asm"

org $02F904|!bank
sumo_bro_fire_tiles:
                                   ; skipped
	db $22,$24,$20,$24,$20,$22,$FF,$20

org $02F980|!bank
sumo_fire:
	JSR.w cls_store_tile1_bank2|!bank
