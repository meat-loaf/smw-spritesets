includefrom "remaps.asm"

!pballoon_tile = $0E

org $01C609+($7D-$74)|!bank
	db !pballoon_tile

if !pballoon_on_sp0_sp1
org $01C6DA|!bank
	STA.w $0302|!addr,y
org $07F3FE+($7D)|!bank
	db $20
else
org $01C6DA|!bank
	JSR store_tile1_bank1
org $07F3FE+$7D|!bank
	db $21
endif
