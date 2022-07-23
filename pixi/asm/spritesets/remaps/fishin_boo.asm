includefrom "remaps.asm"

; cloud, cloud, head, fishing pole, cloud, cloud,
; fishin' line, fishin' line, fishin' line, fire
; (fire index here is actually skipped by the gfx routine)
org $039160|!bank
	db $60,$60,$04,$06,$60,$60
	db $08,$08,$08,$0C

; fishin' boo's fire
org $039174|!bank
	db $0A,$0C,$0A,$0C
