includefrom "remaps.asm"

!dino_skooshed_tile = $04

; squished dino torch
org $019B0B|!bank
	db #!dino_skooshed_tile

org $039E12|!bank
dino_torch_flame_tiles:
	db $20,$22,$24,$26,$00,$28,$2A,$2C
	db $2E,$00
dino_torch_props:
	db $09,$05,$05,$05,$0F
dino_torch_tiles:
	db $02,$00,$06,$08
org $039E39|!bank
; walking x2, fire breathe l/r, fire breathe up
; walk 1 (x4), walk 2 (x4)
dino_rhino_tiles:
	db $40,$42,$44,$46,$40,$42,$48,$4A
