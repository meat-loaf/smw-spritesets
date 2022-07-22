includefrom "remaps.asm"
; the second tile shall be directly adjacent to the right
!mine_tile = $0C
org $01B686|!bank
	db !mine_tile
