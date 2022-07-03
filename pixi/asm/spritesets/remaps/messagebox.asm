includefrom "remaps.asm"

if !remap_message_box
; message box tile
org $038DB0|!bank
	db $08
org $038DB1|!bank
	JSR.w store_tile1_bank3

; 166E val
org $07F3FE+$B9|!bank
	db $37
else
org $038DB0|!bank
	db $C0
org $038DB1|!bank
	STA.w $0302|!addr,y
; 166E val
org $07F3FE+$B9|!bank
	db $36
endif
