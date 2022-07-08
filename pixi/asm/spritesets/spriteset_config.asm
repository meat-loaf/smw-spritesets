includefrom "spritesets.asm"

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

; put the p-balloon powerup on low part of sprite tiles
!pballoon_on_sp0_sp1      = 0

; put the yoshi egg sprite on low part of sprite tiles
!yoshi_egg_on_sp0_sp1     = 0

; put the yoshi fireball extended sprite on low part of sprite tiles
!yoshi_fireball_on_sp0_sp1 = 0

; alternate behavior for sprite A5 (originally, the game
; used the sprite tilemap setting)
!wall_fuzzy_alt_behav     = 1

; if pixi is installed, use the extra bit of sprite A5
; to determine which to act like. if disabled, use the
; sprite tilemap setting as typical. note that they share
; the same tile index now, though
; unset acts like the fuzzy, set acts like the hothead
!wall_fuzzy_alt_exbit     = 1

; disable the dynamic graphics for the podoboo, and have it
; act like a normal sprite instead.
!podoboo_notdynamic       = 1

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
!have_extra_bits = 0
;; pixi detection ;;
if read4($02FFE2) == $44535453          ; "STSD" in little-endian
	if (read1($02FFE2+$4)) != !PIXI_VER
		error "Unsupported PIXI version."
	endif

	!pixi_installed = 1
	!have_extra_bits = 1
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
; Bounce sprites sprite table (4 bytes)
!bnc_spriteset_offset = $9D3C|!extram_bank

; ram used to hold the current spriteset. Change as needed.
!current_spriteset        = $5C
;; ----- end freeram ----- ;;

; This needs to be on direct page, it's best not to change it.
!tile_off_scratch         = $45
; a small amount of sprites will precalculate a certain tile
; before storing. Currently, only the brown spinning platform
; does this.
!precalc_single_scratch   = $46

if !sa1
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
