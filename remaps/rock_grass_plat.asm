includefrom "remaps.asm"

; graphics routine: original was kind of a clusterfuck.
; still is but managed to squeeze some space out of this one
; frankly it used a pitiful amount of scratch ram before
org $01B398|!bank
rockplat_gfx:
	; previously: get draw info
	STZ.b $00     ; flag for drawing sprite $5E
	;LDA.b !9E,x
	%sprite_num(LDA,x)

	STA.b $04
	CMP.b #$5E
	BNE .nowide
	INC.b $00     ; saves reloading oam index
.nowide
	LDA.w !15F6,x
	STA.b $03
