		# void MatMult(int x[][], int y [][], int z[][]
		# matrix z = x*y
		# int i. j. k
		# 
		# for(i=0; i != rowlen; i++)
		#	for(j=0; j != rowlen; j++
		#		for(k=0; k != rowlen; k++)
		#			z[i][j] = x[i][k] * y[k][j];
		#
		# $a0 is base for array x 
		# $a1 is base for array y
		# $a2 is base for array z
		# $a3 is rowlen

.text
.globl MatMult

MatMult:

		addi $t0, $zero 0 	# $t0 = i = 0, init for first loop
Loop1:	
		addi $t1, $zero 0 	# $t1 = j = 0, init for second loop
Loop2:	
		addi $t8, $zero, 0	# $t8 will accumulate Z[i][j], initially 0
		addi $t2, $zero 0 	# $t2 = k = 0, init for inner loop
Loop3:
		mul $t3, $t0, $a3	# $t3 = rowlen * i 
		addu $t3, $t3, $t2	# $t3 = rowlen * i + k
		sll $t3, $t3, 2		# $t3 = 4-byte offset of above
		addu $t3, $t3, $a0	# $t3 = address of x[i][[k]

		lw $t3, 0($t3)		# $t3 = x[j][k]

		mul $t4, $t2, $a3	# $t4 = rowlen * k 
		addu $t4, $t4, $t1	# $t4 = rowlen * k + j
		sll $t4, $t4, 2		# $t4 = 4-byte offset of above
		addu $t4, $t4, $a1	# $t4 = address of y[k][[j]

		lw $t4, 0($t4)		# $t4 = y[k][j]

		mul $t7, $t3, $t4	# $t8 = x[i][k]*y[k][j]
		add $t8, $t8, $t7       # add product to Z[i][j]

		addiu $t2, $t2, 1	# k = k+1
		bne $a3, $t2, Loop3	# continue Loop3 if k != rowlen, end of row
		
		mul $t5, $t0, $a3	# $t5 = rowlen * i 
		addu $t5, $t5, $t1	# $t5 = rowlen * i + j
		sll $t5, $t5, 2		# $t5 = 4-byte offset of above
		addu $t5, $t5, $a2	# $t5 = address of Z[i][[j]

		sw $t8, 0($t5)		# store value to Z[i][j]

		addiu $t1, $t1, 1	# j = j+1
		bne $a3, $t1, Loop2	# continue Loop2 if j != rowlen
		addiu $t0, $t0, 1	# i = i+1
		bne $a3, $t0, Loop1	# continue Loop2 if i != rowlen

		jr $ra
