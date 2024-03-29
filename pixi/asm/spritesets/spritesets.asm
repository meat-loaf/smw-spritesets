incsrc "spriteset_config.asm"
incsrc "spriteset_macros.asm"

incsrc "finish_oam_write.asm"

;; bank 00 hijacks ;;

; hijack gamemode 11 to do spriteset graphics upload
; note: uberasm's hijack is too late to do this, as sprite inits have already run.
org $0096F8|!bank
ss_hijack:
if !hijack_lm_code == 0
	skip 3
autoclean \
	JML.l spriteset_setup_nolm|!bank
	warnpc $009705|!bank
else
	JML.l ss_set_spriteset|!bank
	NOP #6
.done:
warnpc $009705|!bank

  if read1($0FF8C6|!bank) != $22
	error "LM Super GFX hijack not installed, or this code has changed. Install this hijack first before patching with LM hijacks."
  else
	!exgfx_table #= read3($0FF7FF)
endif
; orignally, a call to the LM code that decompresses graphics files after
; pulling the graphics file number from a long pointer at $8A
org $0FF8C6|!bank
	JSL.l spriteset_setup_lm
endif

;; bank 01 hijacks ;;
; replace brown spinning platform main
%replace_wide_pointer($01868A|!bank,brown_plat_main)

; subspr gfx 0 optimization
org $019CFC|!bank
	; saves a byte, originally LDY/TYA for no discernable reason
	LDA.b $0F
	CLC
	ADC.b $01
	STA.b $01
	%sprite_num(LDY,x)
	LDA.w !1602,x
	ASL   #2
	ADC.w $019C7F|!bank,y
	STA.b $02
	LDA.w !15F6,x
	ORA.b $64
	STA.b $03
	LDY.w !15EA,x
	LDA.b #$03
	STA.b $04
subspr_gfx0_drawloop:
	; skip carry clear due to ASL above, and
	; ASL for props after should ensure its clear on loop iters)
	LDA.b $02
	ADC.b $04
	TAX
	LDA.w $019B83|!bank,x
;	ADC.b !tile_off_scratch
	LDX.b $04
	STA.w $0302|!addr,y
	LDA.b $00
	ADC.w $019CD3|!bank,x
	STA.w $0300|!addr,y
	LDA.b $01
	CLC
	ADC $019CD7|!bank,x
	STA $0301|!addr,y
	LDA.b $05
	ASL   #2
	ADC.b $04
	TAX
	LDA.w $019CDB|!bank,x
	ORA.b $03
	STA.w $0303|!addr,y
	INY #4
	DEC.b $04
	BPL subspr_gfx0_drawloop
	LDX.w $15E9|!addr
	LDA.b #$03
	LDY.b #$00
	JMP.w _finish_oam_write|!bank
warnpc $019D5F|!bank

spr_tmap_off = $019C7F|!bank
spr_tiles    = $019B83|!bank
org $019D67|!bank
SubSprGFX1:
;	JSR.w $01A365|!bank
	JSR.w getdrawinfo_generic_prefix|!bank
	LDA.w !15F6,x
	STA.b $02
	%sprite_num(LDA,x)
	CMP.b #$0F
	BCS .nostdsprite
	; standard sprites with wings use the first
	; assigned oam slot, apparently
	INY #4
.nostdsprite
	STY.b $05
	%sprite_num(LDY,x)
	LDA.w !1602,x
	ASL
	; generic sprite routine: tilemap offsets
	ADC.w spr_tmap_off,y
	TAX
	; generic sprite routine: sprite tiles
	LDA.w spr_tiles,x
	ADC.b !tile_off_scratch
	STA.b $03
	LDA.w spr_tiles+1,x
	ADC.b !tile_off_scratch
	STA.b $04
	LDX.w $15E9|!addr
	LDY.b $05
	LDA.b $02
	BPL.b .rightside_up
	LDA.b $03
	STA.w $0306|!addr,y
	LDA.b $04
	STA.w $0302|!addr,y
	BRA.b .tile_done
.rightside_up
	LDA.b $03
	STA.w $0302|!addr,y
	LDA.b $04
	STA.w $0306|!addr,y
.tile_done
	LDA.b $01
	STA.w $0301|!addr,y
	CLC
	ADC.b #$10
	STA.w $0305|!addr,y
	LDA.b $00
	STA.w $0300|!addr,y
	STA.w $0304|!addr,y
	LDA.w !157C,x
	LSR
	LDA.b #$00
	ORA !15F6,x
	BCS .face_other_side
	ORA.b #$40
.face_other_side
	ORA.b $64
	STA.w $0303|!addr,y
	STA.w $0307|!addr,y
	TYA
	LSR   #2
	TAY
	LDA.b #$02
	ORA.w !15A0,x
	STA.w $0460|!addr,y
	STA.w $0461|!addr,y
	JMP.w $01A3DF|!bank
brown_plat_main:
	LDA   !spriteset_offset,x
	STA.b !tile_off_scratch
	CLC
	ADC #!brown_plat_ball_tile_num
	STA.b !precalc_single_scratch
	; the original main
	JMP.w $01C773|!bank
extsprite_spawn_bank1:
%altsprite_spawn($170B|!addr,!ext_spriteset_offset, \
                 !extended_sprites_inherit_parent, "!spriteset_offset,x", \
                 !ext_off_on_wram_mirror,ext_sprset_init|!bank, RTS)
warnpc $019E0D|!bank

; subsprgfx 2 optimization
org $019F0F|!bank
	JSR.w getdrawinfo_generic_prefix|!bank
org $019F27|!bank
	; carry cleared at $019F1C, we get to save a (needed) byte
	ADC.b !tile_off_scratch
	STA.w $0302|!addr,y
	LDX.w $15E9|!addr
	LDA.b $00
	STA.w $0300|!addr,y
	LDA.b $01
	STA.w $0301|!addr,y
	; saves a byte (1/2): stored earlier but this routine just reloaded from the table?
	LDA.b $02
	LSR
	LDA.b #$00
	ORA.w !15F6,x
	BCS .noflip
	EOR.b #$40
.noflip:
	ORA.b $04|!bank
	ORA.b $64|!bank
	STA.w $0303|!addr,y
	TYA
	LSR  #2
	TAY
	LDA #$02
	ORA.w !15A0,x
	STA $0460|!addr,y
	; saves a byte (2/2): originally jsr'd then rts'd after. we just JMP and save the byte + 12 cycles
	JMP.w $A3DF
warnpc $019F5B|!bank

; this space is freed by the fish being fully remapped onto SP3/4.
org $01B110|!bank
store_tile1_bank1:
	%storetile_hijack(!tile_off_scratch,$0302|!addr,RTS)

; a couple of the generic gfx routines don't use finishoamwrite,
; so we supplement here
getdrawinfo_generic_prefix:
	LDA   !spriteset_offset,x
	STA.b !tile_off_scratch
	JMP.w $01A365|!bank
warnpc $01B129|!bank

;; bank 02 hijacks ;;

; free data in bank 02
org $02D51E|!bank
store_tile1_bank2:
	%storetile_hijack(!tile_off_scratch,$0302|!addr,RTS)
; a handful of sprites save the needed space in their routines by jumping to here.
call_finoamwrite_large_bank2:
	LDY.b #$02
	JSL finish_oam_write|!bank
	RTS
ext_store_tile1_lo_bank2:
	%storetile_hijack("!ext_spriteset_offset,x", $0202|!addr,RTS)
mex_store_tile1_lo_bank2:
	LDX.w $1698|!addr
.noloadx
	%storetile_hijack("!mex_spriteset_offset,x", $0202|!addr,RTS)
; this is messy but the best I will do for now...
cls_store_tile1_bank2:
	LDX.w $15E9|!addr
.noloadx
	%storetile_hijack("!cls_spriteset_offset,x", $0302|!addr,RTS)
; A has the sprite to spawn, Y has its slot.
; X has the sprite spawning it.
extsprite_spawn_bank2:
%altsprite_spawn($170B|!addr,!ext_spriteset_offset, \
                 !extended_sprites_inherit_parent, "!spriteset_offset,x", \
                 !ext_off_on_wram_mirror,ext_sprset_init|!bank, RTS)
; starts from cluster sprite index 3
cluster_spawn_bank2:
if !cluster_sprites_inherit_parent
	JSL sprset_cluster_init_inherit|!bank
else
	STA $1892|!addr,x
	STX.b $8E
	STY.b $8F
	TXY
	JSL cls_sprset_init
	LDX.b $8E
	LDY.b $8F
endif
.init_done              ; if inheriting is enabled, we jump back here.
	RTS
mexsprite_spawn_bank2:
%altsprite_spawn($17F0|!addr,!mex_spriteset_offset, \
                 !minorextended_sprites_inherit_parent, "!spriteset_offset,x", \
                 !mex_off_on_wram_mirror,mex_sprset_init|!bank, RTS)
warnpc $02D580|!bank

;; bank 03 freespace
org $03D6AC|!bank
store_tile1_bank3:
	%storetile_hijack(!tile_off_scratch,$0302|!addr,RTS)
extsprite_spawn_bank3:
%altsprite_spawn($170B|!addr,!ext_spriteset_offset, \
                 !extended_sprites_inherit_parent, "!spriteset_offset,x", \
                 !ext_off_on_wram_mirror,ext_sprset_init|!bank, RTS)
mexsprite_spawn_bank3:
%altsprite_spawn($17F0|!addr,!mex_spriteset_offset, \
                 !minorextended_sprites_inherit_parent, "!spriteset_offset,x", \
                 !mex_off_on_wram_mirror,mex_sprset_init|!bank, RTS)
warnpc $03D700|!bank

;; bank 07 hijacks ;;

if !pixi_installed == 1
org $07F77F|!bank
sprset_sprload_hijack:
autoclean \
	JML.l sprset_init
	NOP #2
.done:
; sadly, pixi hijacks here. so we insert our hijack before it...
warnpc $07F785|!bank
else
org $07F785|!bank
autoclean \
	JML.l sprset_init
endif

freecode
sprset_init:
if !pixi_installed == 1
	STZ.w !1504,x
	STZ.w !1FD6,x
else
	LDA.b #$01
	STA.w !15A0,x
	PHP
endif

	PHY
	PHX

	LDA.b #spritesets>>16
	STA.b $8F

if !pixi_installed == 1
	LDA   !extra_bits,x
	AND.b #$08
	BEQ.b .notcustom
	LDA   !7FAB9E,x
	REP.b #$30
	AND.w #$00FF
	ASL
	TAX
	LDA.l spriteset_off_ptrs_custom,x
	BRA.b .custom_done
endif
.notcustom:
	%sprite_num(LDA,x)
	REP #$30
	AND #$00FF
	ASL
	TAX
	LDA.l spriteset_off_ptrs,x
.custom_done
	STA.b $8D
	SEP #$30
	LDY   !current_spriteset
	LDA.b [$8D],y
	PLX
	STA   !spriteset_offset,x
	PLY
if !pixi_installed == 1
	PLP
	JML.l sprset_sprload_hijack_done
else
	RTL
endif

if !cluster_sprites_inherit_parent
sprset_cluster_init_inherit:
	STA $1892|!addr,x
	STX.b $8D
	TAX
	LDA.b #spriteset_off_ptrs>>16
	STA.b $8C
	LDA.l .cluster_inherit_map-3,x
	REP.b #$30
	AND.w #$00FF
	ASL
	TAX
	LDA.l spriteset_off_ptrs,x
	STA.b $8A
	SEP #$30
	TYX
	LDY   !current_spriteset
	LDA.b [$8A],y
	TXY
	LDX.b $8D
	STA   !cls_spriteset_offset,x
	RTL
; boo ceiling, boo ring, castle flames,
; sumo fire pillar, boo formation, swooper ceiling
.cluster_inherit_map:
	db $37,$37,$1F,$9A,$37,$BE
endif ; !cluster_sprites_inherit_parent


if or(not(!extended_sprites_inherit_parent), !use_extended_spriteset_table)
ext_sprset_init:
	%nonstandard_sprset_init($170B|!addr,!ext_sprset_offset, \
                                 !ext_off_on_wram_mirror, ext_spriteset_off_ptrs, $15E9|!addr, RTL)
endif

if or(not(!cluster_sprites_inherit_parent), !use_cluster_spriteset_table)
cls_sprset_init:
	%nonstandard_sprset_init($1892|!addr,!cls_spriteset_offset, \
                                 !cls_off_on_wram_mirror,cls_spriteset_off_ptrs, $15E9|!addr, RTL)
endif

if or(not(!minorextended_sprites_inherit_parent), !use_minorextended_spriteset_table)
mex_sprset_init:
	%nonstandard_sprset_init($17F0|!addr,!mex_spriteset_offset, \
                                 !mex_off_on_wram_mirror,mex_spriteset_off_ptrs, $1698|!addr, RTL)
endif

if !hijack_lm_code == 0
spriteset_setup_nolm:
	LDX.b #$07           ; \
.loop:                       ; | restore hijacked code
	LDA.b $1A,x          ; |
	STA.w $1462|!addr,x  ; |
	DEX                  ; |
	BPL.b .loop          ; /

	REP.b #$10
	LDX.w $010B|!addr
	LDA.l level_spriteset,x
	STA   !current_spriteset
	SEP.b #$10
	JML.l $009705|!bank
else
; pull spriteset before sprite inits run. By default, it uses the low byte of the SP3 graphics
; file number to determine the spriteset.
ss_set_spriteset:
	LDX.b #$07           ; \
.loop:                       ; | restore hijacked code
	LDA.b $1A,x          ; |
	STA.w $1462|!addr,x  ; |
	DEX                  ; |
	BPL.b .loop          ; /

	LDA.b #(!exgfx_table>>16)
	STA.b $8C
	REP.b #$30
	LDA.w #!exgfx_table
	STA.b $8A
	LDA.w $010B
	ASL   #5
	CLC
	ADC.w #$0012                  ; SP3 graphics file index
	TAY
	LDA.b [$8A],y
	CMP.w #$007F
	BNE.b .spriteset_ok
	LDA.w #$0000
.spriteset_ok
	SEP.b #$30
	STA !current_spriteset
	JML.l ss_hijack_done|!bank
; AXY are 16 bit here. $8A contains a pointer to the level's ExGFX list, and Y
; is the index to the current file to be uploaded. We will use the lower 8 bits
; of the SP3 ExGFX file number as the spriteset number. The others can be used
; for other things during load time, if desired.
spriteset_setup_lm:
	PHX : PHY : PHA : PHP
	; note: this code is called with 8-bit axy when not using
	; note: LM's super gfx bypass, 16-bit otherwise. i'd like a more proper
	; note: way to detect this, though: maybe it's in the 32 bytes of
	; note: ram at $7FC000 somewhere.

	; check if we're 16 or 8 bit A:
	; loads EA00 with 16 bit A, or LDA #$00 : NOP
	; with 8-bit A.
	LDA.w #$EA00
	BPL.b .skip
	SEP.b #$20
	LDA.w $0100|!addr
	CMP.b #$12
	BNE.b .skip
	CPY.w #$0012          ; SP3 index
	BEQ.b .ss_continue
	CPY.w #$0010          ; SP4 index
	BEQ.b .ss_continue
.skip:
	PLP : PLA : PLY : PLX
	JML.l $0FF900|!bank
.ss_continue:
	TYX
	LDY.w #$0003
	LDA !current_spriteset
	REP.b #$20
	AND.w #$00FF
	ASL   #4
	CLC
	; x will be 0012 or 0010 here
	; the result is an index into the graphics table
	; based on the spriteset number
	ADC.l .indexes-$10,x
	TAX
.gfx_loop:
	LDA.l spriteset_gfx_listing,x
	; decomp gfx
	JSL.l $0FF900|!bank
	LDA.b $00
	CLC
	; 1KB file
	ADC.w #$0400
	; NOTE: technically we should check for needing to inc the high byte here,
	; but I don't think thats a realistic scenario (default ram is 7EAD00,
	; unlikely to ever change nor be near the bank border as thats where the map16
	; data goes...).
	STA.b $00
	DEX : DEX
	DEY
	BPL.b .gfx_loop

	LDA.w #$AD00      ; \ restore original upload destination
	STA.b $00         ; / (unsure when this is actually set)
	PLP : PLA : PLY : PLX
	RTL
.indexes:
	dw $0006,$000E
endif

incsrc "spriteset_listing.asm"

pushpc
incsrc "remaps.asm"
pullpc

print "freespace used: ", freespaceuse, " bytes."
print "modified ", bytes, " bytes."
