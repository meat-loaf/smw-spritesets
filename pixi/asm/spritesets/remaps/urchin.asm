includefrom "remaps.asm"

!urchin_eye_open_tile   = $06
!urchin_eye_closed_tile = $08

org $02BF58|!bank
urchin_tiles:
	db $00,$02,$04,$00
; TODO| rewrite this graphics routine. making the eye 8x8 would
; TODO| be nice but there might not be enough room to do it inline
; urchin_gfx:
; warnpc $02BFC8
org $02BFB1|!bank
	JSR.w store_tile1_bank2
org $02BFA3|!bank
	db !urchin_eye_open_tile
org $02BFA9|!bank
	db !urchin_eye_closed_tile
