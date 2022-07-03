includefrom "remaps.asm"

; boo ring spawn
org $02AB2F|!bank
	JSR.w cluster_spawn_bank2

; appearing/disappearing boos (sprite E5)
org $02AA94|!bank
	JSR.w cluster_spawn_bank2

; boo ceiling spawn
org $02AADF|!bank
	JSR.w cluster_spawn_bank2

; boo ring tilemap
org $02FBBF|!bank
	db $02,$00,$04,$06,$08,$0A,$00,$02

; X reloaded in tile store; push/pull unecessary
org $02FD6E|!bank
	NOP
org $02FD76|!bank
	NOP
; boo ring tile draw
org $02FD73|!bank
	JSR.w cls_store_tile1_bank2
