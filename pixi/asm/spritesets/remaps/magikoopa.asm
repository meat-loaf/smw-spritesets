includefrom "remaps.asm"

!magikoopa_wand_tile            = $1B

!magikoopas_magic_circle_tile   = $0A
!magikoopas_magic_square_tile   = $0B
!magikoopas_magic_triangle_tile = $1A

; magikoopa
org $019BF6|!bank
	db $00,$02,$00,$02,$06,$08,$06,$08
	db $00,$02,$00,$02

org $01BF05|!bank
	db !magikoopa_wand_tile

org $01BD83|!bank
	db !magikoopas_magic_circle_tile

org $01BD88|!bank
	db !magikoopas_magic_square_tile

org $01BD8D|!bank
	db !magikoopas_magic_triangle_tile
