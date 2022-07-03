includefrom "remaps.asm"

; TODO this remapping causes the bullet bill dead frames
; TODO to always use the horizontal bill frame.
; TODO I think what happens is when the bill is stomped it's updated
; TODO to use frame 0 regardless of what direction its moving.
; TODO the 15F6 table isn't updated, though, and the original horiz
; TODO tile (A6) correspons to the diag/up down tile the bills
; TODO originally used when stomped. Look for a fix

; horz, vert, diag up/right, diag down/left tiles
org $019BCA|!bank
;	db $A6,$A4,$A6,$A8
	db $00,$02,$04,$06

; bullet bill yxppccct props
; horz right, horz left, vert up, vert down,
; diag down left, diag up left, diag up right, diag down right
org $018FC7|!bank
	db $43,$03,$03,$83,$03,$43,$03,$43
