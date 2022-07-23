includefrom "remaps.asm"

!fuzzy_tile = $0E

; part of the grinder's gfx routine...
org $01DBD2|!bank
	BRA.b fuzz_gfx_hijack_fin

org $01DBED|!bank
fuzz_gfx_hijack:
	LDA.b $14
	; ANDing first guarantees free carry clear
	AND.b #$04
	LSR   #2
	TAX
	LDA.b #!fuzzy_tile
	STA.w $0302|!addr,y
	LDA.w $01DC09|!bank,x
	ORA.b $64
	STA.w $0303|!addr,y
	LDA.b #$00
.fin
	PLX
	JMP.w $01B37E|!bank
warnpc $01DC0A|!bank

; wall following sparky/fuzzball
org $02BE5B|!addr
wall_fuzz:
	LDA.b #!fuzzy_tile
	STA.w $0302|!addr,y
if !wall_fuzzy_alt_behav
  if !have_extra_bits && !wall_fuzzy_alt_exbit
	LDA   !extra_bits,x
	AND.b #$04
  else
	LDA $192B|!addr
	CMP.b #$02
  endif
        BNE.b .alt
endif
	LDA.b $14
	AND.b #$04
	LSR   #2
	TAX
	LDA.w $02BE4C|!bank,x
	ORA.b $64
	STA.w $0303|!addr,y
	LDX $15E9|!addr
	RTS
if !wall_fuzzy_alt_behav
.alt:
	LDA.b $14
	AND.b #$0C
	ASL   #4
	EOR.w $0303|!addr,y
	STA.w $0303|!addr,y
	RTS
endif
warnpc $02BE90|!addr
