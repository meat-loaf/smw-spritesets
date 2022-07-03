!blurp_tile_mclosed = $0A
!blurp_tile_mopen   = $0C

includefrom "remaps.asm"

org $0384DD|!bank
	db !blurp_tile_mclosed
org $0384E1|!bank
	db !blurp_tile_mopen
org $0384E2
	JSR.w store_tile1_bank3
