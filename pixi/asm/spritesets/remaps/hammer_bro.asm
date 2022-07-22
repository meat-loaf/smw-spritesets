includefrom "remaps.asm"

org $02DAC5|!bank
	JSR.w extsprite_spawn_bank2|!bank

org $02DAF1|!bank
hammer_bro_tiles:
	db $14,$04,$00,$02
	db $04,$14,$02,$00

