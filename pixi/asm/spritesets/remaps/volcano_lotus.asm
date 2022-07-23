includefrom "remaps.asm"

org $02E008|!bank
volcano_lotus_top_tiles:
	db $02,$12,$00
; i dont think a nearly 50 cycle overhead for this sprite by replacing
; tile stores with jsrs is acceptable, so i moved this.
; the lotus used the 'mushroom scale' sprite gfx routine for
; most of its work, for whatever reason, but i reimplemented that
org $02E00B|!bank
	JSR.w $02E57E|!bank
	JML.l volcano_lotus_gfx|!bank

org $02E092|!bank
	JSR.w extsprite_spawn_bank2|!bank
pullpc
volcano_lotus_gfx:
	    ; this is the tile number for the bottom
	LDY.w !15EA,x
	LDA.b #$04
	STA.w $0302|!addr,y
	STA.w $0306|!addr,y
	LDA.w $0303|!addr,y
	AND.b #$30
	ORA.b #$0B
	STA.w $0303|!addr,y
	ORA.b #$40
	STA.w $0307|!addr,y
	LDA.w !1602,x
	TAX
	LDA.w volcano_lotus_top_tiles,x
	STA.w $030A|!addr,y
	INC
	STA.w $030E|!addr,y
	LDX.w $15E9|!addr
	LDA.w $0300|!addr,y
	; CLC
	ADC.b #$08
	STA $0308|!addr,y
	CLC
	ADC.b #$08
	STA.w $030C|!addr,y
	LDA.w $0301|!addr,y
	STA.w $0309|!addr,y
	STA.w $030D|!addr,y
	LDA.w !151C,x
	CMP.b #$01
	LDA.b #$39
	BCC +
	LDA.b #$35
+
	STA.w $030B|!addr,y
	STA.w $030F|!addr,y
	LDA.w !15EA,x
	CLC
	ADC.b #$08
	STA.w !15EA,x
	LDY.b #$00
	LDA.b #$01
	JML.l $02B7A7|!bank       ; finish oam write call in bank 02
pushpc
