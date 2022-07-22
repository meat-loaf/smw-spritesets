includefrom "remaps.asm"

org $019B83+(read1($019C7F+$1D))|!bank
	db $0B,$09

org $018F8E|!bank
	JSR.w extsprite_spawn_bank1

; ext flame remap
org $02A217|!bank
	db $1D,$0D
org $02A243|!bank
	LDX.w $15E9|!bank
	JSR.w ext_store_tile1_lo_bank2|!bank
	LDA.w $0203|!addr,y
	AND.b #$3F
	ORA.b #$05
	STA.w $0203|!addr,y
	RTS
warnpc $02A254|!bank
