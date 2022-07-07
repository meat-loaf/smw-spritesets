incsrc "spriteset_config.asm"
incsrc "spriteset_macros.asm"

;; bank 00 hijacks ;;

; hijack gamemode 11 to do spriteset graphics upload
; note: uberasm's hijack is too late to do this, as sprite inits have already run.
org $0096F8|!bank
if !hijack_lm_code == 0
        ; original music upload routine
	; TODO check if amk hijacks here
	JSR.w $008134|!bank
autoclean \
	JML spriteset_setup_nolm
	warnpc $009705|!bank
else
restore:
	LDX #$07           ; \
.loop:                     ; | restore original code
	LDA.b $1A,x        ; |
	STA $1462|!addr,x  ; |
	DEX                ; |
	BPL .loop          ; /
	JSR.w $008134|!bank
	warnpc $009705|!bank

if read1($0FF8C6|!bank) != $22
	error "LM Super GFX hijack not installed, or this code has changed. Install this hijack first before patching with LM hijacks."
endif
; orignally, a call to the LM code that decompresses graphics files after
; pulling the graphics file number from a long pointer at $8A
org $0FF8C6|!bank
	JSL.l spriteset_setup_lm
endif

;; bank 01 hijacks ;;
; replace brown spinning platform main, it doesnt call getdrawinfo
%replace_wide_pointer($01868A|!bank,brown_plat_main)

; subspr gfx 0 optimization
org $019CFC|!bank
	; saves a byte, originally LDY/TYA for no discernable reason
	LDA.b $0F
	CLC
	ADC.b $01
	STA.b $01
;	LDY   !9E,x
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
	; move tile store up: skip carry clear due to ASL above, and
	; ASL for props after should ensure its clear on loop iters)
	LDA.b $02
	ADC.b $04
	TAX
	LDA.w $019B83|!bank,x
	ADC.b !tile_off_scratch
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
	JMP.w $01B7BB|!bank
warnpc $019D5F|!bank

spr_tmap_off = $019C7F|!bank
spr_tiles    = $019B83|!bank
org $019D67|!bank
SubSprGFX1:
	; get draw info
	JSR.w $01A365|!bank
	LDA.w !15F6,x
	STA.b $02
;	LDA   !9E,x
	%sprite_num(LDA,x)
	CMP.b #$0F
	BCS .nostdsprite
	; standard sprites with wings use the first
	; assigned oam slot, apparently
	INY #4
.nostdsprite
	STY.b $05
	;LDY   !9E,x
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

org $01A3DC|!bank
	JMP.w getdrawinfo_bank1_hijack

org $01CD1E|!bank
getdrawinfo_bank1_hijack:
	%getdrawinfo_hijack(!tile_off_scratch, RTS)
warnpc $01CD2A|!bank

; this space is freed by the fish being fully remapped onto SP3/4.
org $01B110|!bank
store_tile1_bank1:
	%storetile_hijack(!tile_off_scratch,$0302|!addr,RTS)
store_tile2_bank1:
	%storetile_hijack(!tile_off_scratch,$0306|!addr,RTS)
store_tile3_bank1:
	%storetile_hijack(!tile_off_scratch,$030A|!addr,RTS)
warnpc $01B129|!bank

;; bank 02 hijacks ;;

org $02D3E4|!bank
	JMP.w getdrawinfo_bank2_hijack

; free data in bank 02
org $02D51E|!bank
getdrawinfo_bank2_hijack:
	%getdrawinfo_hijack(!tile_off_scratch, RTS)
store_tile1_bank2:
	%storetile_hijack(!tile_off_scratch,$0302|!addr,RTS)
store_tile2_bank2:
	%storetile_hijack(!tile_off_scratch,$0306|!addr,RTS)
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

;; bank 03 hijacks ;;

; bank3 getdrawinfo
org $03B7CC|!bank
	JMP.w getdrawinfo_bank3_hijack

;; bank 03 freespace
org $03D6AC|!bank
getdrawinfo_bank3_hijack:
	%getdrawinfo_hijack(!tile_off_scratch, RTS)
store_tile1_bank3:
	%storetile_hijack(!tile_off_scratch,$0302|!addr,RTS)
; TODO maybe just move the cloud tile into the spriteset
fishin_boo_tilestore_bank3:
	CPX.b #$02
	BCC.b store_tile1_bank3_tile_store
	CPX.b #$04
	BCC.b store_tile1_bank3
	CPX.b #$06
	BCC.b store_tile1_bank3_tile_store
	BRA.b store_tile1_bank3
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

org $07F78B|!bank
; originally, this routine preserved Y, but doesnt use it itself.
; we get the JSL we want 'for free' by removing pushing Y as we then
; have a 'tidied' stack, so we just go right into loading the tweaker bytes
; instead of JSLing to the routine like the game originally did.
load_sprite_tables:
	PHX
	%sprite_num(LDA,x)
	TAX
	LDA.l $07F3FE,x
	AND.b #$0F
	PLX
	STA.w !15F6,x
autoclean \
	JSL.l sprset_init
	BRA load_tweaker_bytes : NOP
warnpc $07F7A0|!bank
org $07F7A0|!bank
load_tweaker_bytes:

freecode
sprset_init:
	PHY
	PHX

	LDA.b #spritesets>>16
	STA.b $8C

if !pixi_installed
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
;	LDA !9E,x
	%sprite_num(LDA,x)
	REP #$30
	AND #$00FF
	ASL
	TAX
	LDA.l spriteset_off_ptrs,x
.custom_done
	STA.b $8A
	SEP #$30
	LDY   !current_spriteset
	LDA.b [$8A],y
	PLX
	STA   !spriteset_offset,x
	PLY
	RTL

; Arguments:
; $00 tile x offset base (byte)
; $01 tile y offset base (byte)
; $02 pointer to tiles table (word)
; * table should have 4 entries for each animation frame
; $04 pointer to props table (word)
; * props for each tile, 4 bytes total. x flip is or'd in.
; $06 pointer to xoff table (word): should be 5 bytes. Index is shifted by 1 if x-flipped
; $08 pointer to yoff table (word)
; $157C,x: Horizontal facing direction
; $1602,x: Animation frame.
; Y: OAM Index
; $0A is clobbered.
sub_spr_gfx_square:
	LDA.w !157C,x
	EOR.b #$01
	CLC
	ROR   #3
	STA.b $0A               ; facing dir

	LDA.w !157C,x
	EOR.b #$01
	ROR
	LDA.b $06
	ADC.b #$00
	STA.b $06
	BCC .nofacing
	INC $07
.nofacing:
	LDA.w !1602,x
	ASL   #2
	ADC.b $02               ; \ offset table
	BCC +                   ; | to point at animation frame
	INC.b $03               ; / (1 frame is 4 tiles)
+
	STA.b $02

	TYX
	LDY.b #$03
; NOTE: in the below, x is the OAM index and Y is the current
; tile index we are drawing!
.loop:
	LDA.b ($02),y           ; tile number
	CLC
	ADC.b !tile_off_scratch
	STA.w $0302|!addr,x
	LDA.b ($04),y           ; tile prop
	ORA.b $0A
	ORA.b $64
	STA.w $0303|!addr,x
	LDA.b ($08),y           ; y off
	ADC.b $01
	STA.w $0301|!addr,x
	LDA.b ($06),y           ; x off
	CLC
	ADC.b $00
	STA.w $0300|!addr,x
	INX #4
	DEY
	BPL.b .loop
	LDX.w $15E9|!addr
	LDA.b #$03
	LDY.b #$02
	JML.l finish_oam_write|!bank
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
	LDX #$07           ; \
.loop:                     ; | restore hijacked code
	LDA.b $1A,x        ; |
	STA $1462|!addr,x  ; |
	DEX                ; |
	BPL .loop          ; /

	REP.b #$10
	LDX.w $010B|!addr
	LDA.l level_spriteset,x
	STA   !current_spriteset
	SEP.b #$10
	JML.l $009705|!bank
else
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
	BEQ.b .set_spriteset_and_upload
	CPY.w #$0010          ; SP4 index
	BEQ.b .skip_set_spriteset
	; if neither, fall through to original code (decomp gfx)
.skip:
	PLP : PLA : PLY : PLX
	JML.l $0FF900|!bank
.set_spriteset_and_upload:
	; already have 8-bit A here
	; low byte of graphics file number (only used for SP3)
	LDA.b [$8A],y
	STA   !current_spriteset
; since this runs in gamemode 12, sprites that are on screen when the level
; loads initially (in gamemode 11) need their tile offsets actually set up.
.fix_sprites:
	SEP.b #$10
	LDX.b #!num_sprites-1
.spr_loop:
	LDA.w !14C8,x
	BEQ.b .next
	JSL.l sprset_init
.next:
	DEX
	BPL.b .spr_loop
	LDX.b #$13
; same issue with cluster sprites, as they can be initialized
; on load as well (Boo buddy circle, other ghost generators)
.cls_loop:
	LDA.w $1892|!addr,x
	BEQ.b .cls_next
if !cluster_sprites_inherit_parent
	JSL.l sprset_cluster_init_inherit|!bank
else
	PHY
	TXY
	JSL.l cls_sprset_init|!bank
	TYX
	PLY
endif
.cls_next
	DEX
	BPL.b .cls_loop
	REP.b #$10
.skip_set_spriteset:
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
