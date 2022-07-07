includefrom "remaps.asm"

; all of the misc yoshi tiles are moved to SP1, in
; place of a flopping fish tile
!yoshi_throat_tile = $DF
!yoshi_tongue_c_tile = $DE
!yoshi_tongue_e_tile = $CE
!yoshi_egg_fragment_tile = $CF

!yoshi_tongue_props = pack_props($00,$00,$04,$00)
!yoshi_egg_frag_props = pack_props($00,$00,$01,$00)

org $01F08B|!bank
	db !yoshi_throat_tile
org $01F097|!bank
	; yoshi throat tile gfx page
	db $00
org $01F488|!bank
	db !yoshi_tongue_c_tile
org $01F48C|!bank
	db !yoshi_tongue_e_tile
org $01F494|!bank
	db !yoshi_tongue_props
org $028EB2|!bank
	db !yoshi_egg_fragment_tile
org $028EBC|!bank
	db !yoshi_egg_frag_props

; full egg
!yoshi_egg_tile_1 = $00
; cracked egg
!yoshi_egg_tile_2 = $02
; there seems to have been another egg tile at some point,
; but both of these frames point to the cracked egg
!yoshi_egg_tile_3 = $02

; yoshi palettes when placed in level also contain tilemap bit
org $018335|!bank
if !yoshi_egg_on_sp0_sp1 = 1
	db $08,$06,$04,$06
else
	db $09,$07,$05,$07
endif

if !yoshi_egg_on_sp0_sp1 == 1
org $07F3FE+$2C|!bank
	db $3A
else
org $07F3FE+$2C|!bank
	db $3B
endif

org ($019B83+read1($019C7F+$2C))|!bank
	db !yoshi_egg_tile_1

org $01F75C|!bank
if !yoshi_egg_on_sp0_sp1 == 1
yoshi_egg_tiles_hibit:
	db $00,$00,$00,$00
else
yoshi_egg_tiles_hibit:
	db $00,$01,$01,$01
endif
yoshi_egg_tiles:
	db $62,!yoshi_egg_tile_3,!yoshi_egg_tile_2,!yoshi_egg_tile_1

org $01F767|!bank
yoshi_egg:
	BEQ .cont

; bypass setting tile again (?)
org $01F790|!bank
	RTS
.cont:
	; generic spr gfx routine 2
	LDA.w !1540,x
	BEQ.b .nostun
	JSR.w $019F0D|!bank
	LDY.w !15EA,x
	LDA.w !1540,x
	LSR   #3
	TAX
	LDA.w $0303|!addr,y
	AND.b #$FE
	ORA.w yoshi_egg_tiles_hibit,x
	STA.w $0303|!addr,y
	ROR
	LDA.w yoshi_egg_tiles,x
	BCC +
if !yoshi_egg_on_sp0_sp1 = 0
	CLC
	ADC !tile_off_scratch
endif
+
	STA.w $0302|!addr,y
	LDX.w $15E9|!addr
	RTS
warnpc $01F7C2|!bank
org $01F7C2|!bank
.nostun:

org $01F298|!bank
yoshi_fire_spawn:
if !yoshi_fireball_on_sp0_sp1 == 0
  ; Due to how Yoshi works, giving him a spriteset to inherit from
  ; is troublesome. So we just hack this in, instead.
  ; TODO take a look at changing this in the future.
  if !extended_sprites_inherit_parent
	JML.l yoshi_fireball_spawn_hijack|!bank
	NOP
.done:
  ; If we are not inheriting, there are no problems
  else
	LDA.b #$11
	JSR.w extsprite_spawn_bank1|!bank
  endif
else
	LDA.b #$11
	STA.w $170B|!addr,y
endif

if !yoshi_fireball_on_sp0_sp1 == 0
pullpc
yoshi_fireball_spawn_hijack:
	STX.b $0F
	LDA.b #$11
	STA.w $170B|!addr,y
	LDA.b #spritesets_yoshi_fireball
	STA.b $8A
	LDA.b #spritesets_yoshi_fireball>>8
	STA.b $8B
	LDA.b #spritesets_yoshi_fireball>>16
	STA.b $8C
	TYX
	LDY   !current_spriteset
	LDA.b [$8A],y
	STA   !ext_spriteset_offset,x
	TXY
	LDX.b $0F
	JML.l yoshi_fire_spawn_done|!bank
pushpc
endif
