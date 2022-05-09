includefrom "remaps.asm"
; koopa tilemap
if !remap_koopa
; shell koopa tiles
org $019B83|!bank
	db $00,$04,$00,$06,$02,$08
	; next three bytes are the shell tilemap, which is unchanged
; naked koopa; 4th byte unused
org $019B8C|!bank
	db $0A,$0C,$0C
	skip 1
	db $0E,$26,$28
; shelless blue koopa; 4th byte unused
org $019B93|!bank
	db $20,$22,$22
	skip 1
	db $24,$26,$28
; sprites 00-0C, 166E tweaker byte
org $07F3FE|!bank
	db $0B,$09,$07,$05,$0B,$09,$07,$05
        db $0B,$0B,$09,$09,$05
else
; shell koopa tiles
org $019B83|!bank
	db $82,$A0,$82,$A2,$84,$A4
	; next three bytes are the shell tilemap, which is unchanged
; naked koopa; 4th byte unused
org $019B8C|!bank
	db $C8,$CA,$CA
	skip 1
	db $CC,$86,$4E
; shelless blue koopa; 4th byte unused
org $019B93|!bank
	db $E0,$E2,$E2
	skip 1
	db $E4,$E0,$E0

; sprites 00-0C, 166E tweaker byte
org $07F3FE|!bank
	db $0A,$08,$06,$04,$0A,$08,$06,$04
        db $0A,$0A,$08,$08,$04
endif


