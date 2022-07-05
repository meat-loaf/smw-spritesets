includefrom "remaps.asm"
; the second tile shall be directly adjacent to the right
!mine_tile = $0C
org $01B686|!bank
	db !mine_tile
	JSR.w store_tile1_bank1|!bank
