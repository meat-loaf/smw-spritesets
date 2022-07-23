includefrom "remaps.asm"

!pipe_tile_left  = $05
!pipe_tile_right = $07

org $02E91A|!bank
	db !pipe_tile_left

org $02E91F|!bank
	db !pipe_tile_right
