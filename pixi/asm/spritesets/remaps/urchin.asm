includefrom "remaps.asm"

!urchin_eye_open_tile   = $06
!urchin_eye_closed_tile = $08

org $02BF58|!bank
urchin_tiles:
	db $00,$02,$04,$00
org $02BFA3|!bank
	db !urchin_eye_open_tile
org $02BFA9|!bank
	db !urchin_eye_closed_tile
