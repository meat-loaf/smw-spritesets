includefrom "remaps.asm"

!ball_n_chain_chain     = $0C
!ball_n_chain_ball_tile = $0E

; chain of ball 'n' chain
org $02D7A4|!bank
	db !ball_n_chain_chain

org $02D82B|!bank
	LDA.b #!ball_n_chain_ball_tile
	NOP
