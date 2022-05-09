includefrom "remaps.asm"
org $03882B|!bank
mega_mole_tile_off_x:

org $038833|!bank
mega_mole_tile_off_y:

org $038837|!bank
mega_mole_tiles:
	db $00,$02,$04,$06,$08,$0A,$0C,$0E

; todo| this could be better, this is practically the same as the original.
; todo| but its better than the 'jsr-at-tile-store' solution
mega_mole_gfx:
	; get draw info
	JSR.w $03B760|!bank
	LDA.w !151C,x
	STA.b $02
	LDA.b $14
	LSR   #2
	CLC
	ADC.w $15E9|!bank
	AND.b #$01
	ASL #2
	STA.b $03
	LDX.b #$03
.loop:
	; push loop index
	PHX
	LDA.b $02
	BNE .facing_left
	INX #4
.facing_left:
	LDA.b $00
	CLC
	ADC.w mega_mole_tile_off_x,x
	STA.w $0300|!addr,y
	; pull loop index
	PLX
	LDA.b $01
	CLC
	ADC.w mega_mole_tile_off_y,x
	STA.w $0301|!addr,y
	; push loop index
	PHX
	TXA
	CLC
	ADC.b $03
	TAX
	LDA.w mega_mole_tiles,x
	CLC
	ADC.b !tile_off_scratch
	STA.w $0302|!addr,y
	LDA.b #$01
	LDX.b $02
	BNE .facing_left_2
	ORA.b #$40
.facing_left_2:
	ORA.b $64
	STA.w $0303|!addr,y
	; pull loop index
	PLX
	; next slot
	INY   #4
	DEX
	BPL .loop
	LDX.w $15E9|!addr
	; jump to grey castle block's version of the below
	JMP.w $038EE1|!bank
	;LDY.b #$02
	;LDA.b #$03
	;JSL.l $01B7B4|!bank
;print "mega mole pc: $", pc
warnpc $03889F|!bank
