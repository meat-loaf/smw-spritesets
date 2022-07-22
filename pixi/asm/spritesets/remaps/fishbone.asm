includefrom "remaps.asm"
!fishbone_head_frame_1 = $0A
!fishbone_head_frame_2 = $0C

; fishbone's tail
org $039788|!bank
	db $09,$09,$19,$19


; frame 1
org $039799|!bank
	db $0A
; frame 2
org $03979D|!bank
	db $0C
; head tile store: piggybacks off generic sprite routine
org $03979E|!bank
	JSR.w store_tile1_bank3

