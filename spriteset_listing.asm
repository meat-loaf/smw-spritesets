@includefrom "spritesets.asm"

spriteset_off_ptrs:
	dw spritesets_koopas                  ; sprite 00 - nakie koopa grn
	dw spritesets_koopas                  ; sprite 01 - nakie koopa red
	dw spritesets_koopas                  ; sprite 02 - nakie koopa blu
	dw spritesets_koopas                  ; sprite 03 - nakie koopa ylw
	dw spritesets_koopas                  ; sprite 04 - koopa grn
	dw spritesets_koopas                  ; sprite 05 - koopa red
	dw spritesets_koopas                  ; sprite 06 - koopa blu
	dw spritesets_koopas                  ; sprite 07 - koopa ylw
	dw spritesets_koopas                  ; sprite 08 - parakoopa grn (flies)
	dw spritesets_koopas                  ; sprite 09 - parakoopa grn (bounces)
	dw spritesets_koopas                  ; sprite 0A - parakoopa red (vert)
	dw spritesets_koopas                  ; sprite 0B - parakoopa red (horz)
	dw spritesets_koopas                  ; sprite 0C - parakoopa ylw (dumb)
	dw spritesets_null_spriteset          ; sprite 0D - bob omb
	dw spritesets_null_spriteset          ; sprite 0E - keyhole
	dw spritesets_goomba                  ; sprite 0F - goomba     (galoomba)
	dw spritesets_goomba                  ; sprite 10 - paragoomba (paragaloomba)
	dw spritesets_buzzy_swooper           ; sprite 11 - buzzy beetle
	dw spritesets_null_spriteset          ; sprite 12 - unused sprite
	dw spritesets_lakitu_spiny            ; sprite 13 - spiny
	dw spritesets_lakitu_spiny            ; sprite 14 - falling spiny
	dw spritesets_fish                    ; sprite 15 - horz fish
	dw spritesets_fish                    ; sprite 16 - vert fish
	dw spritesets_fish                    ; sprite 17 - generator fish
	dw spritesets_fish                    ; sprite 18 - jumping fish
	dw spritesets_null_spriteset          ; sprite 19 - message box display
	dw spritesets_piranhas                ; sprite 1A - piranha plant
	dw spritesets_chucks                  ; sprite 1B - chuck football
	dw spritesets_bills                   ; sprite 1C - bullet bill
	dw spritesets_null_spriteset          ; sprite 1D - hoppin' flame
	dw spritesets_lakitu_spiny            ; sprite 1E - lakitu/fishin' lakitu
	dw spritesets_magikoopa_bgflame       ; sprite 1F - magikoopa
	dw spritesets_magikoopa_bgflame       ; sprite 20 - magikoopa's magic
	dw spritesets_null_spriteset          ; sprite 21 - moving coin
	dw spritesets_climbing_koopas         ; sprite 22 - net koopa (grn, vert)
	dw spritesets_climbing_koopas         ; sprite 23 - net koopa (red, vert)
	dw spritesets_climbing_koopas         ; sprite 24 - net koopa (grn, horz)
	dw spritesets_climbing_koopas         ; sprite 25 - net koopa (red, horz)
	dw spritesets_thwomp_thwimp_spike     ; sprite 26 - thwomp
	dw spritesets_thwomp_thwimp_spike     ; sprite 27 - thwimp
	dw spritesets_bigboo_smashplayers     ; sprite 28 - big boo
	dw spritesets_null_spriteset          ; sprite 29 - koopa kids
	dw spritesets_piranhas                ; sprite 2A - upside-down piranha
	dw spritesets_null_spriteset          ; sprite 2B - sumo bros lightning
	dw spritesets_null_spriteset          ; sprite 2C - yoshi egg
	dw spritesets_null_spriteset          ; sprite 2D - baby yoshi (grn)
	dw spritesets_spiketop_raft           ; sprite 2E - spike top
	dw spritesets_null_spriteset          ; sprite 2F - springboard
	dw spritesets_dry_bones_beetle_pencil ; sprite 30 - dry bones, throws bones
	dw spritesets_dry_bones_beetle_pencil ; sprite 31 - bony beetle
	dw spritesets_dry_bones_beetle_pencil ; sprite 32 - dry bones, stays on ledge
	dw spritesets_null_spriteset          ; sprite 33 - podoboo
	dw spritesets_null_spriteset          ; sprite 34 - boss fireball
	dw spritesets_null_spriteset          ; sprite 35 - yoshi
	dw spritesets_null_spriteset          ; sprite 36 - unused sprite
	dw spritesets_boo_booblock            ; sprite 37 - boo
	dw spritesets_eerie_fishin_boo        ; sprite 38 - eerie
	dw spritesets_eerie_fishin_boo        ; sprite 39 - wave eerie
	dw spritesets_null_spriteset          ; sprite 3A - urchin, fixed
	dw spritesets_null_spriteset          ; sprite 3B - urchin, wall-aware
	dw spritesets_null_spriteset          ; sprite 3C - urchin, wall-follow
	dw spritesets_null_spriteset          ; sprite 3D - rip van fish
	dw spritesets_null_spriteset          ; sprite 3E - pow switch
	dw spritesets_null_spriteset          ; sprite 3F - para-goomba
	dw spritesets_null_spriteset          ; sprite 40 - para-bomb
	dw spritesets_dolphin                 ; sprite 41 - dolphin, long horz jump
	dw spritesets_dolphin                 ; sprite 42 - dolphin, short horz jump
	dw spritesets_dolphin                 ; sprite 43 - dolphin, vert jump
	dw spritesets_null_spriteset          ; sprite 44 - torpedo ted
	dw spritesets_null_spriteset          ; sprite 45 - directional coin
	dw spritesets_chucks                  ; sprite 46 - diggin' chuck
	dw spritesets_fish                    ; sprite 47 - magic fish
	dw spritesets_chucks                  ; sprite 48 - diggin' chuck's rock
	dw spritesets_null_spriteset          ; sprite 49 - dong pipe
	dw spritesets_null_spriteset          ; sprite 4A - goal sphere
	dw spritesets_lakitu_spiny            ; sprite 4B - pipe lakitu
	dw spritesets_null_spriteset          ; sprite 4C
	dw spritesets_monty_mole_pokey        ; sprite 4D - ground monty mole
	dw spritesets_monty_mole_pokey        ; sprite 4E - ledge monty mole
if !remap_jumpin_pplant_vine
	dw spritesets_piranhas                ; sprite 4F - jumpin' piranha plant
	dw spritesets_piranhas                ; sprite 50 - jumpin' piranha plant, spits fire
else
	dw spritesets_null_spriteset          ; sprite 4F - jumpin' piranha plant
	dw spritesets_null_spriteset          ; sprite 50 - jumpin' piranha plant, spits fire
endif 
	dw spritesets_null_spriteset          ; sprite 51
	dw spritesets_null_spriteset          ; sprite 52
	dw spritesets_null_spriteset          ; sprite 53
	dw spritesets_null_spriteset          ; sprite 54
	dw spritesets_wood_checkered_plats    ; sprite 55 - horizonal checkered platform
	dw spritesets_null_spriteset          ; sprite 56 - horz flying rock platform
	dw spritesets_wood_checkered_plats    ; sprite 57 - vertical checkered platform
	dw spritesets_null_spriteset          ; sprite 58 - vert flying rock platform
	dw spritesets_null_spriteset          ; sprite 59
	dw spritesets_null_spriteset          ; sprite 5A
	dw spritesets_wood_checkered_plats    ; sprite 5B - brown wood plat, floats
	dw spritesets_wood_checkered_plats    ; sprite 5C - checkered platform, floats
	dw spritesets_null_spriteset          ; sprite 5D
	dw spritesets_null_spriteset          ; sprite 5E
	dw spritesets_wood_checkered_plats    ; sprite 5F - brown platform on chain (moves when mario stands on it)
	dw spritesets_null_spriteset          ; sprite 60
	dw spritesets_spiketop_raft           ; sprite 61 - skull raft
	dw spritesets_wood_checkered_plats    ; sprite 62 - brown line guided platform (starts on its own)
	dw spritesets_wood_checkered_plats    ; sprite 63 - brown/checkered line guided platform (starts when jumped on)
	dw spritesets_null_spriteset          ; sprite 64
	dw spritesets_null_spriteset          ; sprite 65
	dw spritesets_null_spriteset          ; sprite 66
	dw spritesets_castle_blk_bnc_gndr     ; sprite 67 - line guided grinder
	dw spritesets_null_spriteset          ; sprite 68
	dw spritesets_null_spriteset          ; sprite 69
	dw spritesets_null_spriteset          ; sprite 6A
	dw spritesets_null_spriteset          ; sprite 6B
	dw spritesets_null_spriteset          ; sprite 6C
	dw spritesets_null_spriteset          ; sprite 6D
	dw spritesets_null_spriteset          ; sprite 6E
	dw spritesets_null_spriteset          ; sprite 6F
	dw spritesets_monty_mole_pokey        ; sprite 70 - pokey
	dw spritesets_vlotus_superkoopas      ; sprite 71 - super koopa (swoops, red cape)
	dw spritesets_vlotus_superkoopas      ; sprite 72 - super koopa (swoops, yellow cape)
	dw spritesets_vlotus_superkoopas      ; sprite 73 - super koopa (running, with feather/ylw cape)
	dw spritesets_null_spriteset          ; sprite 74
	dw spritesets_null_spriteset          ; sprite 75
	dw spritesets_null_spriteset          ; sprite 76
	dw spritesets_null_spriteset          ; sprite 77
	dw spritesets_null_spriteset          ; sprite 78
	dw spritesets_null_spriteset          ; sprite 79
	dw spritesets_null_spriteset          ; sprite 7A
	dw spritesets_null_spriteset          ; sprite 7B - goal point tape
	dw spritesets_null_spriteset          ; sprite 7C
	dw spritesets_null_spriteset          ; sprite 7D
	dw spritesets_null_spriteset          ; sprite 7E - red flying coin
	dw spritesets_null_spriteset          ; sprite 7F - gold 1up
	dw spritesets_null_spriteset          ; sprite 80 - key
	dw spritesets_null_spriteset          ; sprite 81 - item roulette
	dw spritesets_null_spriteset          ; sprite 82
	dw spritesets_null_spriteset          ; sprite 83 - flying question block, left
	dw spritesets_null_spriteset          ; sprite 84 - flying question block, back and forth
	dw spritesets_null_spriteset          ; sprite 85
	dw spritesets_null_spriteset          ; sprite 86
	dw spritesets_null_spriteset          ; sprite 87
	dw spritesets_null_spriteset          ; sprite 88
	dw spritesets_null_spriteset          ; sprite 89
	dw spritesets_null_spriteset          ; sprite 8A
	dw spritesets_null_spriteset          ; sprite 8B
	dw spritesets_null_spriteset          ; sprite 8C
	dw spritesets_null_spriteset          ; sprite 8D
	dw spritesets_null_spriteset          ; sprite 8E
	dw spritesets_null_spriteset          ; sprite 8F
	dw spritesets_bigboo_smashplayers     ; sprite 90 - gas bubble
	dw spritesets_chucks                  ; sprite 91 - Chargin' Chuck
	dw spritesets_chucks                  ; sprite 92 - Splittin' Chuck
	dw spritesets_chucks                  ; sprite 93 - Bouncin' Chuck
	dw spritesets_chucks                  ; sprite 94 - Whistlin' Chuck
	dw spritesets_chucks                  ; sprite 95 - Clappin' Chuck
	dw spritesets_chucks                  ; sprite 96 - Chargin' Chuck clone
	dw spritesets_chucks                  ; sprite 97 - Puntin' Chuck
	dw spritesets_chucks                  ; sprite 98 - Pitchin' Chuck
	dw spritesets_vlotus_superkoopas      ; sprite 99 - volcano lotus
	dw spritesets_null_spriteset          ; sprite 9A
	dw spritesets_null_spriteset          ; sprite 9B
	dw spritesets_null_spriteset          ; sprite 9C
	dw spritesets_null_spriteset          ; sprite 9D - forest bubble
	dw spritesets_castle_blk_bnc_gndr     ; sprite 9E - ball 'n' chain
	dw spritesets_banzai_bill             ; sprite 9F - Banzai Bill
	dw spritesets_null_spriteset          ; sprite A0
	dw spritesets_null_spriteset          ; sprite A1
	dw spritesets_null_spriteset          ; sprite A2
	dw spritesets_null_spriteset          ; sprite A3
	dw spritesets_null_spriteset          ; sprite A4
	dw spritesets_null_spriteset          ; sprite A5
	dw spritesets_null_spriteset          ; sprite A6
	dw spritesets_null_spriteset          ; sprite A7
	dw spritesets_blargg                  ; sprite A8 - blargg
	dw spritesets_null_spriteset          ; sprite A9
	dw spritesets_thwomp_thwimp_spike     ; sprite AA - fishbone
	dw spritesets_rex                     ; sprite AB
	dw spritesets_dry_bones_beetle_pencil ; sprite AC - wooden spike, down then up
	dw spritesets_dry_bones_beetle_pencil ; sprite AD - wooden spike, up then down
	dw spritesets_eerie_fishin_boo        ; sprite AE - fishin' boo
	dw spritesets_boo_booblock            ; sprite AF - boo block
	dw spritesets_boo_booblock            ; sprite B0 - boo stream
	dw spritesets_null_spriteset          ; sprite B1
	dw spritesets_thwomp_thwimp_spike     ; sprite B2 - falling spike
	dw spritesets_null_spriteset          ; sprite B3
	dw spritesets_castle_blk_bnc_gndr     ; sprite B4 - non-line-guided grinder
	dw spritesets_null_spriteset          ; sprite B5
	dw spritesets_dry_bones_beetle_pencil ; sprite B6 - reflecting fireball
	dw spritesets_carrot_timed_plats      ; sprite B7 - carrot plat down-right
	dw spritesets_carrot_timed_plats      ; sprite B8 - carrot plat up-left
	dw spritesets_messagebox              ; sprite B9 - message box
	dw spritesets_carrot_timed_plats      ; sprite BA - timed platform
	dw spritesets_castle_blk_bnc_gndr     ; sprite BB - grey moving castle block
	dw spritesets_null_spriteset          ; sprite BC
	dw spritesets_null_spriteset          ; sprite BD - sliding blue koopa
	dw spritesets_buzzy_swooper           ; sprite BE - swooper
	dw spritesets_null_spriteset          ; sprite BF
	dw spritesets_null_spriteset          ; sprite C0
	dw spritesets_null_spriteset          ; sprite C1 - flying grey turn blocks
	dw spritesets_null_spriteset          ; sprite C2
	dw spritesets_porcupuffer             ; sprite C3
	dw spritesets_null_spriteset          ; sprite C4
	dw spritesets_bigboo_smashplayers     ; sprite C5 - big boo boss
	dw spritesets_null_spriteset          ; sprite C6
	dw spritesets_null_spriteset          ; sprite C7 - invisible mushroom
	dw spritesets_null_spriteset          ; sprite C8 - light switch block
if !pixi_installed
; your custom sprite pointers here, if desired.
.custom:
	dw spritesets_null_spriteset          ; custom sprite 00
	dw spritesets_null_spriteset          ; custom sprite 01
	dw spritesets_null_spriteset          ; custom sprite 02
	dw spritesets_null_spriteset          ; custom sprite 03
	dw spritesets_null_spriteset          ; custom sprite 04
	dw spritesets_null_spriteset          ; custom sprite 05
	dw spritesets_null_spriteset          ; custom sprite 06
	dw spritesets_null_spriteset          ; custom sprite 07
	dw spritesets_null_spriteset          ; custom sprite 08
	dw spritesets_null_spriteset          ; custom sprite 09
	dw spritesets_null_spriteset          ; custom sprite 0A
	dw spritesets_null_spriteset          ; custom sprite 0B
	dw spritesets_null_spriteset          ; custom sprite 0C
	dw spritesets_null_spriteset          ; custom sprite 0D
	dw spritesets_null_spriteset          ; custom sprite 0E
	dw spritesets_null_spriteset          ; custom sprite 0F
	dw spritesets_null_spriteset          ; custom sprite 10
	dw spritesets_null_spriteset          ; custom sprite 11
	dw spritesets_null_spriteset          ; custom sprite 12
	dw spritesets_null_spriteset          ; custom sprite 13
	dw spritesets_null_spriteset          ; custom sprite 14
	dw spritesets_null_spriteset          ; custom sprite 15
	dw spritesets_null_spriteset          ; custom sprite 16
	dw spritesets_null_spriteset          ; custom sprite 17
	dw spritesets_null_spriteset          ; custom sprite 18
	dw spritesets_null_spriteset          ; custom sprite 19
	dw spritesets_null_spriteset          ; custom sprite 1A
	dw spritesets_null_spriteset          ; custom sprite 1B
	dw spritesets_null_spriteset          ; custom sprite 1C
	dw spritesets_null_spriteset          ; custom sprite 1D
	dw spritesets_null_spriteset          ; custom sprite 1E
	dw spritesets_null_spriteset          ; custom sprite 1F
	dw spritesets_null_spriteset          ; custom sprite 20
	dw spritesets_null_spriteset          ; custom sprite 21
	dw spritesets_null_spriteset          ; custom sprite 22
	dw spritesets_null_spriteset          ; custom sprite 23
	dw spritesets_null_spriteset          ; custom sprite 24
	dw spritesets_null_spriteset          ; custom sprite 25
	dw spritesets_null_spriteset          ; custom sprite 26
	dw spritesets_null_spriteset          ; custom sprite 27
	dw spritesets_null_spriteset          ; custom sprite 28
	dw spritesets_null_spriteset          ; custom sprite 29
	dw spritesets_null_spriteset          ; custom sprite 2A
	dw spritesets_null_spriteset          ; custom sprite 2B
	dw spritesets_null_spriteset          ; custom sprite 2C
	dw spritesets_null_spriteset          ; custom sprite 2D
	dw spritesets_null_spriteset          ; custom sprite 2E
	dw spritesets_null_spriteset          ; custom sprite 2F
	dw spritesets_null_spriteset          ; custom sprite 30
	dw spritesets_null_spriteset          ; custom sprite 31
	dw spritesets_null_spriteset          ; custom sprite 32
	dw spritesets_null_spriteset          ; custom sprite 33
	dw spritesets_null_spriteset          ; custom sprite 34
	dw spritesets_null_spriteset          ; custom sprite 35
	dw spritesets_null_spriteset          ; custom sprite 36
	dw spritesets_null_spriteset          ; custom sprite 37
	dw spritesets_null_spriteset          ; custom sprite 38
	dw spritesets_null_spriteset          ; custom sprite 39
	dw spritesets_null_spriteset          ; custom sprite 3A
	dw spritesets_null_spriteset          ; custom sprite 3B
	dw spritesets_null_spriteset          ; custom sprite 3C
	dw spritesets_null_spriteset          ; custom sprite 3D
	dw spritesets_null_spriteset          ; custom sprite 3E
	dw spritesets_null_spriteset          ; custom sprite 3F
	dw spritesets_null_spriteset          ; custom sprite 40
	dw spritesets_null_spriteset          ; custom sprite 41
	dw spritesets_null_spriteset          ; custom sprite 42
	dw spritesets_null_spriteset          ; custom sprite 43
	dw spritesets_null_spriteset          ; custom sprite 44
	dw spritesets_null_spriteset          ; custom sprite 45
	dw spritesets_null_spriteset          ; custom sprite 46
	dw spritesets_null_spriteset          ; custom sprite 47
	dw spritesets_null_spriteset          ; custom sprite 48
	dw spritesets_null_spriteset          ; custom sprite 49
	dw spritesets_null_spriteset          ; custom sprite 4A
	dw spritesets_null_spriteset          ; custom sprite 4B
	dw spritesets_null_spriteset          ; custom sprite 4C
	dw spritesets_null_spriteset          ; custom sprite 4D
	dw spritesets_null_spriteset          ; custom sprite 4E
	dw spritesets_null_spriteset          ; custom sprite 4F
	dw spritesets_null_spriteset          ; custom sprite 50
	dw spritesets_null_spriteset          ; custom sprite 51
	dw spritesets_null_spriteset          ; custom sprite 52
	dw spritesets_null_spriteset          ; custom sprite 53
	dw spritesets_null_spriteset          ; custom sprite 54
	dw spritesets_null_spriteset          ; custom sprite 55
	dw spritesets_null_spriteset          ; custom sprite 56
	dw spritesets_null_spriteset          ; custom sprite 57
	dw spritesets_null_spriteset          ; custom sprite 58
	dw spritesets_null_spriteset          ; custom sprite 59
	dw spritesets_null_spriteset          ; custom sprite 5A
	dw spritesets_null_spriteset          ; custom sprite 5B
	dw spritesets_null_spriteset          ; custom sprite 5C
	dw spritesets_null_spriteset          ; custom sprite 5D
	dw spritesets_null_spriteset          ; custom sprite 5E
	dw spritesets_null_spriteset          ; custom sprite 5F
	dw spritesets_null_spriteset          ; custom sprite 60
	dw spritesets_null_spriteset          ; custom sprite 61
	dw spritesets_null_spriteset          ; custom sprite 62
	dw spritesets_null_spriteset          ; custom sprite 63
	dw spritesets_null_spriteset          ; custom sprite 64
	dw spritesets_null_spriteset          ; custom sprite 65
	dw spritesets_null_spriteset          ; custom sprite 66
	dw spritesets_null_spriteset          ; custom sprite 67
	dw spritesets_null_spriteset          ; custom sprite 68
	dw spritesets_null_spriteset          ; custom sprite 69
	dw spritesets_null_spriteset          ; custom sprite 6A
	dw spritesets_null_spriteset          ; custom sprite 6B
	dw spritesets_null_spriteset          ; custom sprite 6C
	dw spritesets_null_spriteset          ; custom sprite 6D
	dw spritesets_null_spriteset          ; custom sprite 6E
	dw spritesets_null_spriteset          ; custom sprite 6F
	dw spritesets_null_spriteset          ; custom sprite 70
	dw spritesets_null_spriteset          ; custom sprite 71
	dw spritesets_null_spriteset          ; custom sprite 72
	dw spritesets_null_spriteset          ; custom sprite 73
	dw spritesets_null_spriteset          ; custom sprite 74
	dw spritesets_null_spriteset          ; custom sprite 75
	dw spritesets_null_spriteset          ; custom sprite 76
	dw spritesets_null_spriteset          ; custom sprite 77
	dw spritesets_null_spriteset          ; custom sprite 78
	dw spritesets_null_spriteset          ; custom sprite 79
	dw spritesets_null_spriteset          ; custom sprite 7A
	dw spritesets_null_spriteset          ; custom sprite 7B
	dw spritesets_null_spriteset          ; custom sprite 7C
	dw spritesets_null_spriteset          ; custom sprite 7D
	dw spritesets_null_spriteset          ; custom sprite 7E
	dw spritesets_null_spriteset          ; custom sprite 7F
	dw spritesets_null_spriteset          ; custom sprite 80
	dw spritesets_null_spriteset          ; custom sprite 81
	dw spritesets_null_spriteset          ; custom sprite 82
	dw spritesets_null_spriteset          ; custom sprite 83
	dw spritesets_null_spriteset          ; custom sprite 84
	dw spritesets_null_spriteset          ; custom sprite 85
	dw spritesets_null_spriteset          ; custom sprite 86
	dw spritesets_null_spriteset          ; custom sprite 87
	dw spritesets_null_spriteset          ; custom sprite 88
	dw spritesets_null_spriteset          ; custom sprite 89
	dw spritesets_null_spriteset          ; custom sprite 8A
	dw spritesets_null_spriteset          ; custom sprite 8B
	dw spritesets_null_spriteset          ; custom sprite 8C
	dw spritesets_null_spriteset          ; custom sprite 8D
	dw spritesets_null_spriteset          ; custom sprite 8E
	dw spritesets_null_spriteset          ; custom sprite 8F
	dw spritesets_null_spriteset          ; custom sprite 90
	dw spritesets_null_spriteset          ; custom sprite 91
	dw spritesets_null_spriteset          ; custom sprite 92
	dw spritesets_null_spriteset          ; custom sprite 93
	dw spritesets_null_spriteset          ; custom sprite 94
	dw spritesets_null_spriteset          ; custom sprite 95
	dw spritesets_null_spriteset          ; custom sprite 96
	dw spritesets_null_spriteset          ; custom sprite 97
	dw spritesets_null_spriteset          ; custom sprite 98
	dw spritesets_null_spriteset          ; custom sprite 99
	dw spritesets_null_spriteset          ; custom sprite 9A
	dw spritesets_null_spriteset          ; custom sprite 9B
	dw spritesets_null_spriteset          ; custom sprite 9C
	dw spritesets_null_spriteset          ; custom sprite 9D
	dw spritesets_null_spriteset          ; custom sprite 9E
	dw spritesets_null_spriteset          ; custom sprite 9F
	dw spritesets_null_spriteset          ; custom sprite A0
	dw spritesets_null_spriteset          ; custom sprite A1
	dw spritesets_null_spriteset          ; custom sprite A2
	dw spritesets_null_spriteset          ; custom sprite A3
	dw spritesets_null_spriteset          ; custom sprite A4
	dw spritesets_null_spriteset          ; custom sprite A5
	dw spritesets_null_spriteset          ; custom sprite A6
	dw spritesets_null_spriteset          ; custom sprite A7
	dw spritesets_null_spriteset          ; custom sprite A8
	dw spritesets_null_spriteset          ; custom sprite A9
	dw spritesets_null_spriteset          ; custom sprite AA
	dw spritesets_null_spriteset          ; custom sprite AB
	dw spritesets_null_spriteset          ; custom sprite AC
	dw spritesets_null_spriteset          ; custom sprite AD
	dw spritesets_null_spriteset          ; custom sprite AE
	dw spritesets_null_spriteset          ; custom sprite AF
	dw spritesets_null_spriteset          ; custom sprite B0
	dw spritesets_null_spriteset          ; custom sprite B1
	dw spritesets_null_spriteset          ; custom sprite B2
	dw spritesets_null_spriteset          ; custom sprite B3
	dw spritesets_null_spriteset          ; custom sprite B4
	dw spritesets_null_spriteset          ; custom sprite B5
	dw spritesets_null_spriteset          ; custom sprite B6
	dw spritesets_null_spriteset          ; custom sprite B7
	dw spritesets_null_spriteset          ; custom sprite B8
	dw spritesets_null_spriteset          ; custom sprite B9
	dw spritesets_null_spriteset          ; custom sprite BA
	dw spritesets_null_spriteset          ; custom sprite BB
	dw spritesets_null_spriteset          ; custom sprite BC
	dw spritesets_null_spriteset          ; custom sprite BD
	dw spritesets_null_spriteset          ; custom sprite BE
	dw spritesets_null_spriteset          ; custom sprite BF
	dw spritesets_null_spriteset          ; custom sprite C0
	dw spritesets_null_spriteset          ; custom sprite C1
	dw spritesets_null_spriteset          ; custom sprite C2
	dw spritesets_null_spriteset          ; custom sprite C3
	dw spritesets_null_spriteset          ; custom sprite C4
	dw spritesets_null_spriteset          ; custom sprite C5
	dw spritesets_null_spriteset          ; custom sprite C6
	dw spritesets_null_spriteset          ; custom sprite C7
	dw spritesets_null_spriteset          ; custom sprite C8
endif

if not(!extended_sprites_inherit_parent) || !use_extended_spriteset_table
ext_spriteset_off_ptrs:
	dw spritesets_null_spriteset          ; extended sprite 00
	dw spritesets_null_spriteset          ; extended sprite 01
	dw spritesets_null_spriteset          ; extended sprite 02
	dw spritesets_null_spriteset          ; extended sprite 03
	dw spritesets_null_spriteset          ; extended sprite 04
	dw spritesets_null_spriteset          ; extended sprite 05
	dw spritesets_null_spriteset          ; extended sprite 06
	dw spritesets_null_spriteset          ; extended sprite 07
	dw spritesets_null_spriteset          ; extended sprite 08
	dw spritesets_null_spriteset          ; extended sprite 09
	dw spritesets_null_spriteset          ; extended sprite 0A
	dw spritesets_null_spriteset          ; extended sprite 0B
	dw spritesets_null_spriteset          ; extended sprite 0C
	dw spritesets_chucks                  ; extended sprite 0D - baseball
	dw spritesets_null_spriteset          ; extended sprite 0E
	dw spritesets_null_spriteset          ; extended sprite 0F
	dw spritesets_null_spriteset          ; extended sprite 10
	dw spritesets_null_spriteset          ; extended sprite 11
	dw spritesets_null_spriteset          ; extended sprite 12
; add your custom extended sprites here, if desired
endif

if not(!cluster_sprites_inherit_parent) || !use_cluster_spriteset_table
cls_spriteset_off_ptrs:
	dw spritesets_null_spriteset          ; cluster sprite 00 - n/a
	dw spritesets_null_spriteset          ; cluster sprite 01 - bonus game cluster 1up
	dw spritesets_null_spriteset          ; cluster sprite 02 - null cluster sprite
	dw spritesets_boo_booblock            ; cluster sprite 03 - boo ceiling boo
	dw spritesets_boo_booblock            ; cluster sprite 04 - boo ring boo
	dw spritesets_null_spriteset          ; cluster sprite 05 - castle candle flame
	dw spritesets_null_spriteset          ; cluster sprite 06 - sumo brother lightning flame
	dw spritesets_null_spriteset          ; cluster sprite 07 - disappearing/reappearing boos
	dw spritesets_buzzy_swooper           ; cluster sprite 08 - swooper death ceiling
; add your custom cluster sprites here, if desired
endif

if not(!minorextended_sprites_inherit_parent) || !use_minorextended_spriteset_table
exm_spriteset_off_ptrs:
endif

spritesets:
if !remap_koopa == 0
.koopas
endif
if !remap_goomba == 0
.goomba:
endif
if !remap_message_box == 0
.messagebox:
endif
.null_spriteset:                              ; used by sprites that don't use the system.
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
if !remap_koopa
.koopas:                                      ; koopa variants
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
endif ; remap_koopa
.buzzy_swooper                                ; buzzy beetle, swooper
	db $00,$00,$00,$00,$A0,$00,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.lakitu_spiny:                                ; lakitu variants, spiny
	db $00,$00,$00,$00,$00,$00,$20,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.fish:
	db $00,$00,$C0,$00,$00,$00,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.chucks:
	db $00,$20,$00,$00,$00,$00,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.monty_mole_pokey:
	db $00,$80,$00,$00,$00,$00,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.banzai_bill:
	db $00,$00,$40,$00,$00,$00,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.rex:
	db $00,$00,$80,$00,$00,$00,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.carrot_timed_plats:
	db $00,$00,$A0,$00,$00,$00,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
if !remap_goomba
.goomba:
endif ; !remap_goomba
if !remap_message_box
.messagebox:
endif
.piranhas:
	db $00,$00,$E0,$00,$C0,$00,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.dolphin
	db $00,$00,$00,$20,$00,$00,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.porcupuffer
	db $00,$00,$00,$40,$00,$00,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.spiketop_raft:
	db $00,$00,$00,$00,$80,$00,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.blargg:
	db $00,$00,$00,$00,$E0,$00,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.bigboo_smashplayers:
	db $00,$00,$00,$00,$00,$20,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.boo_booblock:
	db $00,$00,$00,$00,$00,$60,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.eerie_fishin_boo:
	db $00,$00,$00,$00,$00,$80,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.dry_bones_beetle_pencil:
	db $00,$00,$00,$00,$00,$00,$00,$20    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.thwomp_thwimp_spike:                         ; also includes fishbone, sprite AA
	db $00,$00,$00,$00,$00,$00,$00,$60    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.climbing_koopas:
	db $00,$00,$00,$00,$00,$00,$00,$80    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.castle_blk_bnc_gndr:
	db $00,$00,$00,$00,$00,$00,$00,$A0    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.magikoopa_bgflame:
	db $00,$00,$00,$00,$00,$00,$00,$C0    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.vlotus_superkoopas
	db $00,$A0,$00,$00,$00,$00,$00,$00    ; spritesets 00-07
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.bills:
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 00-07
	db $20,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F
.wood_checkered_plats:
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 00-07
	db $40,$00,$00,$00,$00,$00,$00,$00    ; spritesets 08-0F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 10-17
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 18-1F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; spritesets 38-3F

level_spriteset:
	db $00,$00,$03,$00,$00,$00,$00,$07    ; levels 0-7
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 8-F
	db $00,$00,$00,$00,$00,$01,$01,$00    ; levels 10-17
	db $00,$00,$00,$00,$00,$00,$05,$00    ; levels 10-1F
	db $00,$00,$00,$08,$00,$00,$00,$00    ; levels 20-27
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 28-2F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 30-37
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 38-3F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 40-47
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 48-4F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 50-57
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 58-5F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 60-67
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 68-6F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 70-77
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 78-7F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 80-87
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 88-8F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 90-97
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 98-9F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels A0-A7
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels A8-AF
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels B0-B7
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels B8-BF
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels C0-C7
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels C8-CF
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels D0-D7
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels D8-DF
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels E0-E7
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels E8-EF
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels F0-F7
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels F8-FF
	db $00,$00,$00,$00,$00,$02,$01,$05    ; levels 100-107
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 108-10F
	db $00,$00,$00,$02,$00,$00,$00,$04    ; levels 110-117
	db $00,$00,$04,$00,$00,$00,$00,$06    ; levels 118-11F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 120-127
	db $00,$00,$00,$00,$00,$02,$00,$00    ; levels 128-12F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 130-137
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 138-13F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 140-147
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 148-14F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 150-157
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 158-15F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 160-167
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 168-16F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 170-177
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 178-17F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 180-187
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 188-18F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 190-197
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 198-19F
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 1A0-1A7
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 1A8-1AF
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 1B0-1B7
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 1B8-1BF
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 1C0-1C7
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 1C8-1CF
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 1D0-1D7
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 1D8-1DF
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 1E0-1E7
	db $00,$00,$05,$00,$00,$00,$00,$04    ; levels 1E8-1EF
	db $00,$00,$00,$00,$00,$00,$00,$00    ; levels 1F0-1F7
	db $00,$00,$00,$05,$00,$00,$00,$00    ; levels 1F8-1FF
