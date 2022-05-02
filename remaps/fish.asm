includefrom "remaps.asm"

; fish
org $019C0D|!bank
	db $04,$06,$00,$02

; fish remapped; remove the tilemap highbyte swap code
org $01B10A|!bank
	JSR.w $019F0D|!bank     ; subsprgfx2
	JMP.w $01AC31|!bank     ; suboffscreen
warnpc $01B110|!bank
; NOTE: the space this saves is utilized by the patch.
;warnpc $01B129|!bank
