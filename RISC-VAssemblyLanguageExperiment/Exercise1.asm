	lui   s1,0xFFFFF

	              
switled:                          # Test led and switch
	lw   s0,0x70(s1)          # read switch
	sw   s0,0x60(s1)          # write led
	lw   s0,0x72(s1)
    sw   s0,0x62(s1)	
	jal switled
