includefrom "remaps.asm"

org $02DAC5|!bank
	JSR.w extsprite_spawn_bank2|!bank

org $02DAF1|!bank
	db $14,$04,$00,$02
	db $04,$14,$02,$00

org $02DB2D|!bank
	JSR.w store_tile1_bank2|!bank
