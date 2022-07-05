includefrom "remaps.asm"

org $02A2DF|!bank
ext_hammer_tiles:
	db $07,$05,$05,$07
	db $07,$05,$05,$07

org $02A327|!bank
	LDA.w $02A2E7|!bank,x
	EOR.b $00
	EOR.b #$40
	ORA.b $64
	STA.b $0203|!addr,y
	LDA.w ext_hammer_tiles,x
	PLX     ; pull extended sprite slot
	JSR.w ext_store_tile1_lo_bank2|!bank
	TYA
	LSR   #2
	TAY
	LDA.b #$02
	STA.b $0420|!addr,y
	RTS
warnpc $02A344|!bank
