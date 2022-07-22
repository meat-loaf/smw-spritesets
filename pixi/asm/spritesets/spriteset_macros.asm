includefrom "spritesets.asm"

function pack_props(flip, priority, palette, page) = ((flip&03)<<$06)|((priority&03)<<$04)|((palette&$07)<<1)|(page&$01)

function shared_spr_routines_tile_addr(spr_num) = $019B83+read1($019C7F+spr_num)

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


