includefrom "remaps.asm"

!wiggler_head_tile       = $00
!wiggler_angry_eyes_tile = $08
!wiggler_flower_tile     = $18
; yxppccct
!wiggler_flower_palette  = $0A

; this is relocated slightly
org $02F0D8|!bank
	JMP.w wiggler_gfx|!bank

org $02F103|!bank
; free space
fillbyte $EA ; NOP
fill $13
wiggler_segment_buff_offs:
	db $00,$1E,$3E,$5E,$7E
wiggler_segment_yoffs:
	db $00,$01,$02,$01
wiggler_body_tiles:
	db $02,$04,$06,$02
wiggler_small_tiles:
	db !wiggler_flower_tile, !wiggler_flower_tile
	db !wiggler_angry_eyes_tile, !wiggler_angry_eyes_tile
wiggler_small_tile_xoffs:
	db $00,$08
	db $04,$04
wiggler_small_tile_yoffs:
	db $F8,$F8
	db $00,$00
wiggler_gfx:
	JSR.w $02D378|!bank
	LDA.w !1570,x     ; \ animation frame counter
	STA.b $03         ; /
	LDA.w !15F6,x     ; \ yxppccct
	STA.b $07         ; /
	LDA.w !151C,x     ; \ wiggler is angry flag
	STA.b $08         ; /
	LDA   !C2,x       ; \ bitfield: segment direction flag
	STA.b $02         ; /
	LDX #$00
.draw_loop:
	INY   #4          ; angry face/flower tile drawn later
	STY.b $0A         ; > sprite OAM index
	STX.b $05
	LDA.b $03
	LSR   #3
	CLC
	ADC.b $05         ; current loop index
	AND.b #$03
	STA.b $06         ; body tile yoff table index
	LDA.w wiggler_segment_buff_offs,x
	LDY.b $08
	BEQ.b .no_angry
	LSR
	AND.b #$FE
.no_angry:
	TAY
	STY.b $09         ; index to segment buffer
	LDA.b [$D5],y
	SEC
	SBC.b $1A
	LDY.b $0A
	STA.w $0300|!addr,y
	LDY.b $09
	INY
	LDA.b [$D5],y
	SEC
	SBC.b $1C
	LDX.b $06
	SEC
	SBC.w wiggler_segment_yoffs,x
	LDY.b $0A
	STA.w $0301|!addr,y
	LDA.b #!wiggler_head_tile
	LDX.b $05
	BEQ .draw_head
	LDX.b $06
	LDA.w wiggler_body_tiles,x
.draw_head:
	LDY.b $0A
	STA.w $0302|!addr,y
	LDA.b $07
	ORA.b $64
	LSR.B $02
	BCS .no_flip
	ORA.b #$40
.no_flip:
	STA.w $0303|!addr,y
	LDX.b $05
	; changing this to a DEX/BPL would require reversing the bitfield
	; in the C2 table, at least
	INX
	CPX.b #$05
	BNE .draw_loop
	LDX $15E9|!addr
	LDY.w !15EA,x
	LDA.b $08
	ASL
	ORA.w !157C,x           ; horz facing dir
	TAX
	LDA.w wiggler_small_tiles,x
	STA.w $0302|!addr,y
	; carry clear free from above: won't overflow
	LDA $0304|!addr,y
	ADC.w wiggler_small_tile_xoffs,x
	STA.w $0300|!addr,y
	LDA.w $0305|!addr,y
	CLC
	ADC.w wiggler_small_tile_yoffs,x
	STA.w $0301|!addr,y
	LDA.w $0307|!addr,y
	CPX #$02
	BCS .not_flower
	AND.b #$F1
	ORA.b #!wiggler_flower_palette
.not_flower:
	STA.w $0303|!addr,y
	TYA
	LSR   #2
	TAY
	LDA.b #$00
	STA.w $0460|!addr,y
	LDA.b #$02
	STA.w $0461|!addr,y
	STA.w $0462|!addr,y
	STA.w $0463|!addr,y
	STA.w $0464|!addr,y
	STA.w $0465|!addr,y
	
	LDX $15E9|!addr
	LDA.b #$05
	LDY.b #$FF
	JSL.l $01B7B3|!bank
; note: pc needs to be at exactly $02F202 here, fill above ensures this
warnpc $02F202|!bank

; extended flower spawn
org $02F2E4|!bank
	JSR.w extsprite_spawn_bank2|!bank

; extended flower sprite: tile store
org $029D2F|!bank
	LDA.b #!wiggler_flower_tile
	JSR.w ext_store_tile1_lo_bank2|!bank
