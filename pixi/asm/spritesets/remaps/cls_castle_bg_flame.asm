; castle bg fire: cluster spawn
org $02AA75|!bank
	JSR.w cluster_spawn_bank2

; cluster fire tiles
org $02FA0E|!bank
	db $0C,$0E,$0C,$0E

org $02FA41|!bank
	NOP         ; replace PHX (X is sprite slot) here...

; shuffle properties/tile store order
org $02FA48|!bank
	LDA.w $02FA12|!bank,x
	STA.w $0303|!addr,y
	LDA.w $02FA0E|!bank,x
	; sprite slot restored here
	JSR.w cls_store_tile1_bank2
	NOP         ; replace PLX
