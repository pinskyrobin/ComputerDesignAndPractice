# a0: initial low 12-bit
# a1: initial high 12-bit
# a2: ultimate low 16-bit
# a3: ultimate high 8-bit
# t0: mode counter
# t1: shift counter
# a7: const var 1
# a6: const var 10
# a5: const var 'b1000_0000_0000
# a4: const var 'b1000_0000_0000_0000_0000_0000

	lui	s1, 0xFFFFF
Mode23ConfigProc:
	# config ultimate register a2
	addi	s0, zero, 0x7F8
	slli	s0, s0, 5
	addi	s0, s0, 0xFF
	and	a2, a0, s0
	
	# config ultimate register a3
	addi	s0, zero, 0x7F8
	slli	s0, s0, 13
	and	t2, a0, s0
	srai	a3, t2, 16
Light:	
	sw	a2, 0x60(s1)
	sw	a3, 0x62(s1)
	sub	t0, t0, a7
	
	jalr 	ra
	
MODE1:
	# initialize params
	addi	t0, zero, 23
	addi	t1, zero, 11
	addi	a0, zero, 1
	addi	a1, zero, 0x400
	slli	a1, a1, 1
	slli	a4, a1, 12
	add	a5, zero, a1
	addi	a6, zero, 10
	addi	a7, zero, 1
	srai	s0, a1, 4
	sw	a0, 0x60(s1)
	sw	s0, 0x62(s1)
	#jal	Wait
Mode1Proc1:
	# config logical register
	slli	a0, a0, 1
	addi	a0, a0, 1
	srai	s0, a1, 1
	add	a1, a5, s0

	# config ultimate register
	addi	s0, zero, 0xF
	and	t2, a1, s0
	slli	t2, t2, 12
	add	a2, t2, a0
	srai	a3, a1, 4
	
	# make lights light!
	jal	Light
	sub	t1, t1, a7
	bne	t1, zero, Mode1Proc1
Mode1Proc2:
	# config logical register
	srai	a0, a0, 1
	slli	a1, a1, 1
	
	# config ultimate register a2
	addi	s0, zero, 0xF
	and	t2, a1, s0
	slli	t2, t2, 12
	add	a2, t2, a0
	
	# config ultimate register a3
	addi	s0, zero, 0x7F8
	slli	s0, s0, 1
	and	t2, a1, s0
	srai	a3, t2, 4
	
	# make lights light!
	jal	Light
	bne	t0, zero, Mode1Proc2
	beq	t0, zero, MODE2
	
MODE2:
	# initialize params
	addi	t0, zero, 48
	addi	t1, zero, 24
	xor	a0, a0, a0
	xor	a1, a1, a1
Mode2Proc1:
	srai	a0, a0, 1
	add	a0, a0, a4
	jal	Mode23ConfigProc
	
	sub	t1, t1, a7
	bne	t1, zero, Mode2Proc1
Mode2Proc2:
	srai	a0, a0, 1
	jal	Mode23ConfigProc
	
	bne	t0, zero, Mode2Proc2
	beq	t0, zero, MODE3

MODE3:
	lw	t1, 0x70(s1)
	addi	t0, zero, 49
	xor	a0, a0, a0
	add	a1, zero, a4
Mode3Proc1:
	or	a0, a0, a1
	srai	a1, a1, 1
	jal	Mode23ConfigProc
	sub	t1, t1, a7
	bne	t1, zero, Mode3Proc1
Mode3Proc2:
	jal	Mode23ConfigProc
	and	t2, a0, a7
	srli	a0, a0, 1
	beq	t2, zero, Mode3Proc2
	or	a0, a0, a4
	beq	t0, zero, MODE1
	bne	t0, zero, Mode3Proc2
	
	