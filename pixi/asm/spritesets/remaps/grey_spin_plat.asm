includefrom "remaps.asm"

org $02D844|!bank
; ball, platform tiles (left, middle, center)
grey_spin_plat_tiles:
	db $04,$00,$01,$02

org $02D7AA
	db !brown_plat_ball_tile_num
