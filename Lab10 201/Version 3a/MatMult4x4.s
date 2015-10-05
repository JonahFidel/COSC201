		# void MatMult(int x[][], int y [][], int z[][]
		# matrix z = x*y
		# int i. j. k
		# 
		# for(Bi=0; Bi != 4; Bi++)
		#   for(Bj=0; Bj != 4; Bj++
		#     for(Bk=0; Bk != 4; Bk++)
		#       for(i=0; i != len/4; i++)
		#         for(j=0; j != len/4; j++)
		#           for(k=0; k != len/4; k++)
		#
		#              z[Bi+i][Bj+j] = x[Bi+i][Bk+k] * y[Bk+k][Bj+j];
		#
		# $a0 is base for array x 
		# $a1 is base for array y
		# $a2 is base for array z
		# $a3 is rowlen: precondition rowlen divisible by 4

.text
.globl MatMult

MatMult:
		srl $s3, $a3, 2		# $s3 = rowlen/4
		addi $t9, $zero, 4	# $t9 = 4, to end inner loops

		addi $s0, $zero, 0	# $s0 = Bi = 0, init for first block loop
LoopB1:
		addi $s1, $zero, 0	# $s1 = Bj = 0, init for second block loop
LoopB2:
		addi $s2, $zero, 0	# $s2 = Bk = 0, init for third block loop
LoopB3:
		addi $t0, $zero 0 	# $t0 = i = 0, init for first loop
Loop1:	
		add $s4, $s0, $t0	# $s4 = Bi+i
		addi $t1, $zero 0 	# $t1 = j = 0, init for second loop
Loop2:	
		add $s5, $s1, $t1	# $s5 = Bj+j
		
		mul $t5, $s4, $a3	# $t5 = rowlen * (Bi+i)
		add $t5, $t5, $s5	# $t5 = rowlen * (Bi+i) + (Bj+j)
		sll $t5, $t5, 2		# $t5 = 4-byte offset of above
		addu $t5, $t5, $a2	# $t5 = address of Z[Bi+i][Bj+j]
		lw $t8, 0($t5)		# $t8 will accumulate Z[Bi+i][Bj+j], initially from memory
		
		addi $t2, $zero 0 	# $t2 = k = 0, init for inner loop
Loop3:
		add $s6, $s2, $t2	# $s6 = Bk+k
		
		mul $t6, $s4, $a3	# $t6 = rowlen * (Bi+i)
		addu $t6, $t6, $s6	# $t6 = rowlen * (Bi+i) + (Bk+k)
		sll $t6, $t6, 2		# $t6 = 4-byte offset of above
		addu $t6, $t6, $a0	# $t6 = address of X[Bi+i][[Bk+k]

		lw $t6, 0($t6)		# $t6 = X[Bi+i][Bk+k]

		mul $t7, $s6, $a3	# $t7 = rowlen * (Bk+k)
		addu $t7, $t7, $s5	# $t7 = rowlen * (Bk+k) + (Bj+j)
		sll $t7, $t7, 2		# $t7 = 4-byte offset of above
		addu $t7, $t7, $a1	# $t7 = address of Y[Bk+k][[Bj+j]

		lw $t7, 0($t7)		# $t7 = Y[Bk+k][[Bj+j]

		mul $t7, $t6, $t7	# $t7 = X[i][k]*Y[k][j]
		add $t8, $t8, $t7       # add product to Z[i][j]

		addiu $t2, $t2, 1	# k = k+1
		bne $t2, $t9, Loop3	# continue Loop3 if k != 4, end of row in subblock
endLoop3:		
		sw $t8, 0($t5)		# store value to Z[i][j]

		addiu $t1, $t1, 1	# j = j+1
		bne $t1, $t9, Loop2	# continue Loop2 if j != 4
endLoop2:
		addiu $t0, $t0, 1	# i = i+1
		bne $t0, $t9, Loop1	# continue Loop2 if i != 4
endLoop1:
		addiu $s2, $s2, 4	# Bk = Bk+4
		bne $s2, $a3, LoopB3	# continue LoopB3 if Bk != rowlen/4
endLoopB3:
		addiu $s1, $s1, 4	# Bj = Bj+4
		bne $s1, $a3, LoopB2	# continue LoopB2 if Bj != rowlen/4
endLoopB2:
		addiu $s0, $s0, 4	# Bi = Bi+4
		bne $s0, $a3, LoopB1	# continue LoopB1 if Bi != rowlen/4
endLoopB1:	

		jr $ra
