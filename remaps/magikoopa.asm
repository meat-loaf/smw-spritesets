includefrom "remaps.asm"

; magikoopa
org $019BF6|!bank
	db $00,$02,$00,$02,$06,$08,$06,$08
	db $00,$02,$00,$02

; magikoopa's wand tile
org $01BF05|!bank
	db $1B
org $01BF06|!bank
	JSR.w store_tile3_bank1

org $01BD82|!bank
	JML.l magikoopa_magic_tilestore
pullpc
magikoopa_magic_tilestore:
	      ; this is the circle tile
	LDA.b #$0A
	CLC
	ADC.b !tile_off_scratch
	STA $0302|!addr,y
	      ; this is the square tile
	LDA.b #$0B
	ADC.b !tile_off_scratch
	STA $0306|!addr,y
	      ; this is the triangle tile
	LDA.b #$1A
	ADC.b !tile_off_scratch
	STA $030A|!addr,y
	JML.l $01BD91|!bank
pushpc
