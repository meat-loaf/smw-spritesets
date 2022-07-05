!parachute_tile_1 = $00
!parachute_tile_2 = $02

!bob_omb_para_top_front = $04
!bob_omb_para_bot_front = $14

!bob_omb_para_side = $06

!goomba_para_top_front = $05
!goomba_para_bot_front = $15

!goomba_para_side = $08

; goomba
org $019B83+(read1($019C7F+$3F))|!bank
	db !goomba_para_top_front,!goomba_para_top_front
	db !goomba_para_bot_front,!goomba_para_bot_front
	db !goomba_para_side+$1,!goomba_para_side
	db !goomba_para_side+$11,!goomba_para_side+$10
	db !goomba_para_side,!goomba_para_side+$1
	db !goomba_para_side+$10,!goomba_para_side+$11
	db !parachute_tile_1,!parachute_tile_2

; para-bob-omb
org $019B83+(read1($019C7F+$40))|!bank
	db !bob_omb_para_top_front,!bob_omb_para_top_front
	db !bob_omb_para_bot_front,!bob_omb_para_bot_front
	db !bob_omb_para_side+$1,!bob_omb_para_side
	db !bob_omb_para_side+$11,!bob_omb_para_side+$10
	db !bob_omb_para_side,!bob_omb_para_side+$1
	db !bob_omb_para_side+$10,!bob_omb_para_side+$11
	db !parachute_tile_1,!parachute_tile_2
