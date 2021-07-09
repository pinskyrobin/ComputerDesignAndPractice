	lui	s1, 0xFFFFF
init:
	
	# read sw[3:0]
	lw	s0, 0x70(s1)
	add	t0, zero, s0
	addi	t1, zero, 0xF
	and	a0, t0, t1
	add	a2, a0, zero
	
	# read sw[23:22], format: XXXX_XXXX_XXXX_XXXX_XXXX_XXXX_11XX_XXXX
	lw	s0, 0x72(s1)
	add	t0, zero, s0
	addi	t1, zero, 0xC0
	and	a7, t0, t1
	
	beq	a7, zero, init	# waiting for input
	
	
	
# SQUARE
	slli	a1, a0, 4	# multiplier
	addi	t0, zero, 1	# const t0 = 1
	addi	t2, zero, 4	# counter
	
OneOrZero2:
	and	t1, a0, t0	# get the lowest bit of [a0]
	beq	t1, zero, SkipPlusOne2
	add	a0, a0, a1
SkipPlusOne2:
	srli	a0, a0, 1
	sub	t2, t2, t0
	bne	t2, zero, OneOrZero2

	# jump if sw[22] isn't equal to 0
	addi	t1, zero, 0x40
	and	t1, a7, t1
	bne	t1, zero, Output

# CUBE
	slli	a1, a0, 8
	add	a0, zero, a2
	addi	t2, zero, 4	# counter
OneOrZero3:
	and	t1, a0, t0	# get the lowest bit of [a0]
	beq	t1, zero, SkipPlusOne3
	add	a0, a0, a1
SkipPlusOne3:
	srli	a0, a0, 1
	sub	t2, t2, t0
	bne	t2, zero, OneOrZero3
	srli	a0, a0, 4
	
Output:
	sw	a0, 0x60(s1)
	sw	a0, 0x0

reset:
	# read sw[21], format: XXXX_XXXX_XXXX_XXXX_XXXX_XXXX_XX1X_XXXX
	lw	s0, 0x72(s1)
	addi	t1, zero, 0x20
	and	t3, s0, t1
	beq	t3, zero, reset
	sw	zero, 0x60(s1)
	
wait:
	# read sw[21], if it's equal to 1, then do nothing
	lw	s0, 0x72(s1)
	addi	t1, zero, 0x20
	and	t3, s0, t1
	bne	t3, zero, wait
	jal	init
	
	