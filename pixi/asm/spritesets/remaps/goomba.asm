includefrom "remaps.asm"


if !remap_goomba
;org $01E733|!bank
;	db $17      ; squished tile

org $019BA8|!bank
	db $0E,$0C,$0C,$0E

; 166E byte, normal goomba
org $07F3FE+$0F|!bank
	db $05
; 166E byte, paragoomba
org $07F3FE+$10|!bank
	db $05
else
org $019BA8|!bank
	db $AA,$A8,$A8,$AA

org $01E733|!bank
	db $C7      ; squished tile

; 166E byte, normal goomba
org $07F3FE+$0F|!bank
	db $04
; 166E byte, paragoomba
org $07F3FE+$10|!bank
	db $04

endif
