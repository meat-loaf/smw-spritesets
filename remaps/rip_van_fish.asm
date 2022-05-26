includefrom "remaps.asm"

org $019C65|!bank
	; two sleeping, two swimming
	db $06,$04,$00,$02

org $02C108|!bank
	JSR.w mexsprite_spawn_bank2|!bank

; rip van fish's 'z' tiles
org $028DD7|!bank
	db $19,$18,$09,$08

org $028E66|!bank
	JSR.w mex_store_tile1_lo_bank2|!bank
