includefrom "remaps.asm"
; goal sphere tile
; this is part of the sprite original tilemaps, an unsed part of
; the naked koopa tilemaps. it originally shared an index
; with one of the monty mole tiles.
org $019B8F|!bank
	db $0E

; goal sphere: offset into generic sprite tilemap table
org $019C7F+$4A|!bank
	db ($019B8F-$019B83)

; 166E tweaker table
org $07F3FE+$4A|!bank
if !goal_sphere_on_sp0_sp1 == 0
	db $0B
else
	db $0A
endif
