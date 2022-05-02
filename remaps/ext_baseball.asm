includefrom "remaps.asm"

; extended baseball - baseball tile
org $02A2A4
	db $43

; extended baseball tile store
org $02A2A5
	JSR.w ext_store_tile1_lo_bank2
