includefrom "remaps.asm"

; chucks - head tiles
org $02C87E|!bank
	db $00,$02,$04,$02,$00,$2B,$2B
; originals
;	db $06,$0A,$0E,$0A,$06,$4B,$4B
; chucks - body tiles 1
org $02C98B|!bank
	db $29,$34,$35,$0E,$26,$2D,$20,$22
	db $2A,$26,$0C,$0C,$0C,$0C,$64,$2D
	db $67,$52,$09,$06,$29,$28,$2A,$42
	db $42,$2A
; originals
;	db $0D,$34,$35,$26,$2D,$28,$40,$42
;	db $5D,$2D,$64,$64,$64,$64,$E7,$28
;	db $82,$CB,$23,$20,$0D,$0C,$5D,$BD
;	db $BD,$5D

; chucks - body tiles 2
org $02C9A5|!bank
	db $46,$28,$22,$0E,$26,$2E,$20,$22
	db $AE,$26,$0C,$0C,$0C,$0C,$65,$2E
	db $68,$44,$0A,$07,$46,$4A,$4A,$4C
	db $4E,$48
; originals
;	db $4E,$0C,$22,$26,$2D,$29,$40,$42
;	db $AE,$2D,$64,$64,$64,$64,$E8,$29
;	db $83,$CC,$24,$21,$4E,$A0,$A0,$A2
;	db $A4,$AE
; chucks - clappin chuck hand tiles
org $02CA97|!bank
	db $28,$24
; originals
;	db $0C,$44

;chucks - running shoulder tile
org $02CB17|!bank
	db $38
; original
;	db $1C
; chucks - baseball tile
org $02CB7C|!bank
	db $43
; original
;	db $AD

; chuck: head tile store
org $02C8F9|!bank
	JSR.w store_tile1_bank2
; all chucks: body tile store 1
org $02CA65|!bank
	JSR.w store_tile1_bank2
; all chucks: body tile store 2
org $02CA6B|!bank
	JSR.w store_tile2_bank2
; clappin chuck tile store - hand tile
org $02CAD9|!bank
	JSR.w store_tile1_bank2
	; A already has the tile number, guess we draw two of the same.
	STA.w $0306|!addr,y
; chargin chuck tile store - shoulder
org $02CB18|!bank
	JSR.w store_tile1_bank2

; pitchin chuck tile store - baseball
org $02CB7D|!bank
	JSR.w store_tile1_bank2

; pitchin' chuck baseball spawn
org $02C47B|!bank
	JSR.w extsprite_spawn_bank2
