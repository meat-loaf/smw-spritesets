includefrom "remaps.asm"

if !remap_jumpin_pplant_vine
org $019BBD|!bank
	db $00,$04,$02,$04
  if !jumpin_pirana_stem_sp0_1
	db $83,$83,$C4,$C4,$83,$83,$C5,$C5
  else
	db $16,$16,$06,$06,$16,$16,$07,$07
  endif
; jumpin' piranha plant: stem properties
; (head properties loaded from cfg)
org $02E10E|!bank
  if !jumpin_pirana_stem_sp0_1
	db $0A
  else
	db $0B
  endif

; growing vine
org $01C19E|!bank
	db $00
org $01C1A2|!bank
	db $02

; 166E vals
org ($07F3FE+$4F)|!bank
	db $09,$09
; growing vine
org ($07F3FE+$79)|!bank
	db $3B

; normal piranha plant
org ($07F3FE+$1A)|!bank
	db $09

; upside-down piranha plant
org ($07F3FE+$2A)|!bank
	db $09
else ; !remap_jumpin_pplant_vine = 0
org $019BBD|!bank
	db $AC,$CE,$AE,$CE
	db $83,$83,$C4,$C4,$83,$83,$C5,$C5
org $02E10E|!bank
	db $0A
; growing vine
org $01C19E
	db $AC
org $01C1A2
	db $AE

; 166E vals
org ($07F3FE+$4F)|!bank
	db $08,$08
; growing vine
org ($07F3FE+$79)|!bank
	db $3A

; normal piranha plant
org $(07F3FE+$1A)|!bank
	db $08
; upside-down piranha plant
org $(07F3FE+$2A)|!bank
	db $08
endif

if !remap_jumpin_pplant_vine && !jumpin_pirana_stem_sp0_1
org $02E114|!bank
	JSL jumpin_piranha_stem_hijack
pullpc
jumpin_piranha_stem_hijack:
; the jumpin' piranha plant calls the LoadSpriteTables subroutine,
; which will reload this value before the graphics routine runs in the following frame
  if !spriteset_off_on_wram_mirror
	STZ !spriteset_offset,x
  else
	LDA #$00
	STA !spriteset_offset,x
  endif
	JML.l $018042|!bank
pushpc
else
org $02E114|!bank
	JSL.l $018042|!bank
endif
