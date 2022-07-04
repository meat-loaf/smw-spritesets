; hijack Lunar Magic's graphics upload to do the spriteset upload handling
; there, instead. As with all lunar magic hijacks, this can break between
; lunar magic versions if FuSoYa decides to change this code for any reason.
; If this hijack proves troublesome, disable this and use the provided
; uberasm gm13 hijack instead.
!hijack_lm_code           = 1

; defines for a handful of remaps for things originally on sp1/2
; moving some of them can reduce sp1/2 pressure for something like
; a sprite status bar, if desired.


; XXX this isn't done, don't toggle this one.
!remap_koopa              = 0

; remaps growing vine and jumpin' piranha plant
!remap_jumpin_pplant_vine = 1
; put the flapping part of the jumpin' piranha plant on SP0/SP1.
; Turns out the SMB3 sideways piranhas/venuses fit nicely in 1 file
; and there's no room for the jumpin' piranha plant's tail, so this
; define installs a small hack to keep it on page 0.
!jumpin_pirana_stem_sp0_1 = 1

; put the goal sphere on low part of sprite tiles
!goal_sphere_on_sp0_sp1   = 0

; alternate behavior for sprite A5 (originally, the game
; used the sprite tilemap setting)
!wall_fuzzy_alt_behav     = 1
; if pixi is installed, use the extra bit of sprite A5
; to determine which to act like. if disabled, use the
; sprite tilemap setting as typical. note that they share
; the same tile index now, though
; unset acts like the fuzzy, set acts like the hothead
!wall_fuzzy_alt_exbit     = 1


!remap_goomba             = 1
!remap_message_box        = 1

; TODO
!remap_coingame_stuffs    = 1

; the rotating brown platform is a funny sprite, and has some
; slightly special handling...its a lot easier to put this here.
!brown_plat_ball_tile_num = $04

; with these settings enabled, the relevant sprite type
; will inherit the tile offset from the normal sprite that is
; spawning it, avoiding the table lookup completely. This is
; typically not an issue, and is much more performant.
!extended_sprites_inherit_parent = 1
!minorextended_sprites_inherit_parent = 1
!cluster_sprites_inherit_parent = 1

; if any of these are enabled, the spriteset tables will be generated
; despite the setting above. These can be used to load the offset for
; custom extended sprites. Note that they are expected to be called from 'normal'
; sprite code: the normal sprite slot is in X (which is loaded from $15E9 at the end)
; and the relevant sprite type slot in Y.
!use_extended_spriteset_table = 0
!use_cluster_spriteset_table = 0
!use_minorextended_spriteset_table = 0

!PIXI_VER = $32

!pixi_installed = 0
;; pixi detection ;;
if read4($02FFE2) == $44535453          ; "STSD" in little-endian
	if (read1($02FFE2+$4)) != !PIXI_VER
		error "Unsupported PIXI version."
	endif

	!pixi_installed = 1
endif

if !sa1
	!extram_bank = $410000
else
	!extram_bank = $7F0000
endif

!num_sprites = !SprSize

;; ------- freeram ------- ;;
; note: Put the sprite tables on wram mirrors if you can.
; note: The patch will generate more efficient code.

; Standard Sprite table (12 bytes on non-SA1, 20 bytes on SA1) used to hold sprite offset.
!spriteset_offset = !1FD6
; Extended Sprite table (10 bytes)
!ext_spriteset_offset = $9D00|!extram_bank
; Cluster Sprite table (20 bytes)
!cls_spriteset_offset = $9D10|!extram_bank
; Minor extended sprite table (12 bytes)
!mex_spriteset_offset = $9D30|!extram_bank

; ram used to hold the current spriteset. Change as needed.
!current_spriteset        = $5C
;; ----- end freeram ----- ;;

; This needs to be on direct page, it's best not to change it.
!tile_off_scratch         = $45
; a small amount of sprites will precalculate a certain tile
; before storing. Currently, only the brown spinning platform
; does this.
!precalc_single_scratch   = $46

if !SA1
; same as in sa1's more_sprites.asm
!sprite_num_cache         = $87
!sprite_ylow_ptr          = $CC
!sprite_xlow_ptr          = $EE
endif

; check if spriteset offset table can use y-indexing and stz
if bank(!spriteset_offset) == bank(!extram_bank)
	!spriteset_off_on_wram_mirror = 0
else
	!spriteset_off_on_wram_mirror = 1
endif

if bank(!ext_spriteset_offset) == bank(!extram_bank)
	!ext_off_on_wram_mirror = 0
else
	!ext_off_on_wram_mirror = 1
endif

if bank(!cls_spriteset_offset) == bank(!extram_bank)
	!cls_off_on_wram_mirror = 0
else
	!cls_off_on_wram_mirror = 1
endif

if bank(!mex_spriteset_offset) == bank(!extram_bank)
	!mex_off_on_wram_mirror = 0
else
	!mex_off_on_wram_mirror = 1
endif

macro sprite_num(operation, index)
if not(!sa1)
	<operation>.b $9E,<index>
else
	<operation>.b !sprite_num_cache
endif
endmacro

macro sprite_y_low(operation, index)
if not(!sa1)
	<operation>.b $D8,<index>
else
	<operation>.b (!sprite_ylow_ptr)
endif
endmacro

macro sprite_x_low(operation, index)
if not(!sa1)
	<operation>.b $E4,<index>
else
	<operation>.b (!sprite_xlow_ptr)
endif
endmacro

macro replace_wide_pointer(location, ptr)
pushpc
org <location>
	dw <ptr>
pullpc
endmacro

macro getdrawinfo_hijack(scratch, return)
	STA.b $01
	LDA   !spriteset_offset,x
	STA   <scratch>
	<return>
endmacro

macro storetile_hijack(scratch, oam, return)
	CLC : ADC <scratch>
.tile_store:
	STA <oam>,y
	<return>
endmacro

macro altsprite_spawn(snum_table, off_table, inherit, inherit_from, on_wram_mirror, noinherit_routine, return)
	STA.w <snum_table>,y
if <inherit>
	LDA <inherit_from>
  if <on_wram_mirror> == 0
	TYX
	STA.l <off_table>,x
	LDX.w $15E9|!addr
  else
	STA.w <off_table>,y
  endif
else
	JSL.l <noinherit_routine>
endif
	<return>
endmacro

; x restored from <current_sprite_ram> value. expects Y to be slot of sprite type
; (this is mostly used when sprites spawn a sprite type)
macro nonstandard_sprset_init(snum_table, off_table, on_wram_mirror, sprset_table, current_sprite_ram, return)
	LDA.b #bank(<sprset_table>)
	STA.b $8C

	STY.b $8D                 ; slot backup
	LDA.w <snum_table>,y
	ASL                       ; a = sprite number << 2
	TAX                       ; x = sprite number << 2
	LDA.l <sprset_table>,x
	STA.b $8A
	LDA.l <sprset_table>+1,x
	STA.b $8B
	LDY   !current_spriteset
	LDA.b [$8A],y             ; a = tile offset for sprite
  if <on_wram_mirror> == 0
	LDX.b $8D                 ; x = sprite slot
	STA.l <off_table>,x
	TXY
	LDX <current_sprite_ram>
  else
	LDY $8D                   ; y = sprite slot
	STA <off_table>,x
	LDX <current_sprite_ram>
  endif
	<return>
endmacro


finish_oam_write = $01B7B3

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
; 14/13 bytes freed (depending on width of !spriteset_offset)
;print pc
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
	JSL $01B7B3|!bank
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
	JML sprset_cluster_init_inherit
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
; All other scratch ram besides $0E-$0F is clobbered
sub_spr_gfx_square:
	LDA.w !157C,x
	EOR.b #$01
	CLC
	ROR   #3
	STA.b $0C               ; facing dir

	LDA.w !157C,x
	EOR.b #$01
	ROR
	LDA.b $06
	ADC.b #$00
	STA.b $06
	BCC +
	INC $07
+
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
	LDA.b ($06),y
	STA.b $0A               ; tile xoff
	LDA.b ($08),y
	STA.b $0B               ; tile yoff
	LDA.b ($04),y
	STA.b $0D               ; tile prop

	LDA.b ($02),y           ; tile number
	CLC
	ADC.b !tile_off_scratch
	STA.w $0302|!addr,x
	LDA.b $0D               ; tile prop
	ORA.b $0C
	ORA.b $64
	STA.w $0303|!addr,x
	LDA.b $01
	ADC.b $0B
	STA.w $0301|!addr,x
	LDA.b $00
	CLC
	ADC.b $0A
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
	JML.l cluster_spawn_bank2_init_done
; boo ceiling, boo ring, castle flames,
; sumo fire pillar, boo formation, swooper ceiling
.cluster_inherit_map:
	db $37,$37,$1F,$9A,$37,$BE
endif ; !cluster_sprites_inherit_parent


if or(not(!extended_sprites_inherit_parent), !use_extended_spriteset_table)
print "ExtendedSpriteSprsetInit = $", pc
ext_sprset_init:
	%nonstandard_sprset_init($170B|!addr,!ext_sprset_offset, \
                                 !ext_off_on_wram_mirror, ext_spriteset_off_ptrs, $15E9|!addr, RTL)
endif

if or(not(!cluster_sprites_inherit_parent), !use_cluster_spriteset_table)
print "ClusterSpriteSprsetInit = $", pc
cls_sprset_init:
	%nonstandard_sprset_init($1892|!addr,!cls_spriteset_offset, \
                                 !cls_off_on_wram_mirror,cls_spriteset_off_ptrs, $15E9|!addr, RTL)
endif


;if or(not(!minorextended_sprites_inherit_parent), !use_minorextended_spriteset_table)
;print "ExtendedSprteSprsetInit = $", pc
;mext_sprset_init: ; todo macro?

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
; AXY are 16 bit here. $8A contains the pointer to the current ExGFX number to be loaded.
; We will use the lower 8 bits of the SP3 ExGFX file number as the spriteset number.
spriteset_setup_lm:
	PHX : PHY : PHA : PHP
	; note this code is called with 8-bit axy when not using
	; note LM's super gfx bypass, 16-bit otherwise. i'd like a more proper
	; note way to detect this, though: maybe it's in the 32 bytes of
	; note ram at $7FC000 somewhere.

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
.indexes
	dw $0006,$000E
endif

incsrc "spriteset_listing.asm"

pushpc
incsrc "remaps.asm"
pullpc

print "freespace used: ", freespaceuse, " bytes."
print "modified ", bytes, " bytes."
